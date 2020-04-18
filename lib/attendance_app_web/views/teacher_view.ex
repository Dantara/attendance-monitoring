defmodule AttendanceAppWeb.TeacherView do
  use AttendanceAppWeb, :view

  def selected_attr(mode, mode),
    do: "selected=\"selected\""
  def selected_attr(_, _), do: ""

  def fullname(f, s) do
    "#{f} #{s}"
  end
end
