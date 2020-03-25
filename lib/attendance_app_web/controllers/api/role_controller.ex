defmodule AttendanceAppWeb.API.RoleController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Accounts
  alias AttendanceApp.Accounts.Role
  alias AttendanceApp.Repo

  action_fallback AttendanceAppWeb.FallbackController

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
