defmodule AttendanceWeb.Router do
  use AttendanceWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/", AttendanceWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", AttendanceWeb do
    pipe_through :api
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end
end
