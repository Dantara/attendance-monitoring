defmodule AttendanceAppWeb.API.RoleView do
  use AttendanceAppWeb, :view
  alias AttendanceAppWeb.API.RoleView

  def render("index.json", %{roles: roles}) do
    %{roles: render_many(roles, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{role: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{id: role.id, title: role.title}
  end
end
