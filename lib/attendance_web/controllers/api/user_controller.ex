defmodule AttendanceWeb.API.UserController do
  use AttendanceWeb, :controller

  alias Attendance.Accounts.User
  alias Pow.Plug
  alias Attendance.Repo

  def show(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload(:role)

    render(conn, "show.json", user: current_user)
  end
end
