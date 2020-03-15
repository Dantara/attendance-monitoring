defmodule AttendanceWeb.Router do
  use AttendanceWeb, :router

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


  scope "/", AttendanceWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", AttendanceWeb do
    pipe_through :api

    resources "/students", StudentController, except: [:new, :edit]
  end
end
