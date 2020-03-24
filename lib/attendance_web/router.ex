defmodule AttendanceWeb.Router do
  use AttendanceWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Pow.Plug.Session, otp_app: :attendance
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug AttendanceWeb.APIAuthPlug, otp_app: :attendance
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: AttendanceWeb.APIAuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: AttendanceWeb.AuthErrorHandler
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: AttendanceWeb.AuthErrorHandler
  end

  scope "/", AttendanceWeb do
    pipe_through [:browser, :not_authenticated]

    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", AttendanceWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :index
    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/api", AttendanceWeb.API do
    pipe_through :api

    resources "/roles", RoleController, only: [:index, :show]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api", AttendanceWeb do
    pipe_through [:api, :api_protected]
  end
end
