defmodule AttendanceAppWeb.API.UserView do
  use AttendanceAppWeb, :view
  alias AttendanceAppWeb.API.UserView
  alias AttendanceAppWeb.API.ClassView

  def render("students.json", %{students: students}) do
    %{students: render_many(students, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      role: user.role.title,
      classes: render_many(user.classes, ClassView, "class.json")
    }
  end
end
