defmodule AttendanceAppWeb.API.UserController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Accounts.User
  alias Pow.Plug
  alias AttendanceApp.Repo

  def show(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload(:role)

    render(conn, "show.json", user: current_user)
  end
end
