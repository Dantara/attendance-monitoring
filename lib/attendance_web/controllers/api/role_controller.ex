defmodule AttendanceWeb.API.RoleController do
  use AttendanceWeb, :controller

  alias Attendance.Accounts
  alias Attendance.Accounts.Role
  alias Attendance.Repo

  action_fallback AttendanceWeb.FallbackController

  def index(conn, _params) do
    roles = Accounts.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def show(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def user_role(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload(:role)

    render(conn, "show.json", role: current_user.role)
  end
end
