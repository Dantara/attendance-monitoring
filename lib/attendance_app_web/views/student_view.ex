defmodule AttendanceAppWeb.StudentView do
  use AttendanceAppWeb, :view

  def selected_attr(mode, mode),
    do: "selected=\"selected\""
  def selected_attr(_, _), do: ""
end
