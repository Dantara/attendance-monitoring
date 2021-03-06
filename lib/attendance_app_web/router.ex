defmodule AttendanceAppWeb.Router do
  use AttendanceAppWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Pow.Plug.Session, otp_app: :attendance_app
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug AttendanceAppWeb.APIAuthPlug, otp_app: :attendance_app
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: AttendanceAppWeb.APIAuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: AttendanceAppWeb.AuthErrorHandler
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: AttendanceAppWeb.AuthErrorHandler
  end

  pipeline :student do
    plug AttendanceAppWeb.EnsureRolePlug, :student
    plug :put_layout, {AttendanceAppWeb.LayoutView, :student}
  end

  pipeline :teacher do
    plug AttendanceAppWeb.EnsureRolePlug, :teacher
    plug :put_layout, {AttendanceAppWeb.LayoutView, :teacher}
  end

  pipeline :admin do
    plug AttendanceAppWeb.EnsureRolePlug, :administrator
    plug :put_layout, {AttendanceAppWeb.LayoutView, :admin}
  end

  pipeline :blocked do
    plug AttendanceAppWeb.EnsureBlockPlug, true
    plug :put_layout, {AttendanceAppWeb.LayoutView, :blocked}
  end

  pipeline :not_blocked do
    plug AttendanceAppWeb.EnsureBlockPlug, false
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through [:browser]

    pow_assent_routes()
  end

  scope "/", AttendanceAppWeb do
    pipe_through [:browser, :not_authenticated]

    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", AttendanceAppWeb do
    pipe_through [:browser, :protected]

    # get "/", PageController, :index
    get "/", PageController, :index
    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/student", AttendanceAppWeb do
    pipe_through [:browser, :protected, :student, :not_blocked]

    get "/", StudentController, :index
    get "/enroll", StudentController, :enroll
    get "/enroll/:id", StudentController, :enroll_to_class
    delete "/enroll/:id", StudentController, :unenroll_to_class
  end

  scope "/teacher", AttendanceAppWeb do
    pipe_through [:browser, :protected, :teacher, :not_blocked]

    get "/", TeacherController, :index
    get "/enroll", TeacherController, :enroll
    get "/enroll/:id", TeacherController, :enroll_to_class
    delete "/enroll/:id", TeacherController, :unenroll_to_class
  end

  scope "/administrator", AttendanceAppWeb, as: :admin do
    pipe_through [:browser, :protected, :admin, :not_blocked]

    get "/", AdminController, :index
    get "/enroll", AdminController, :enroll
    get "/blocking", AdminController, :blocking
    get "/registration", RegistrationController, :new_admin
    post "/registration", RegistrationController, :create_admin
  end

  scope "/blocked", AttendanceAppWeb do
    pipe_through [:browser, :protected, :blocked]

    get "/", BlockController, :index
  end

  scope "/api", AttendanceAppWeb.API do
    pipe_through :api

    resources "/roles", RoleController, only: [:index, :show]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api", AttendanceAppWeb.API do
    pipe_through [:api, :api_protected]

    get "/user_role", RoleController, :user_role
    get "/current_user", UserController, :show
    resources "/activities", ActivityController, except: [:new, :edit]
    resources "/classes", ClassController, except: [:new, :edit]
    resources "/presences", PresenceController, except: [:new, :edit]
    get "/user_presences", PresenceController, :user_presences
    get "/user_classes", ClassController, :user_classes
    get "/class_students/:id", UserController, :class_students
  end
end
