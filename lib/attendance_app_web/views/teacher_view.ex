defmodule AttendanceAppWeb.TeacherView do
  use AttendanceAppWeb, :view

  def selected_attr(mode, mode),
    do: "selected=\"selected\""
  def selected_attr(_, _), do: ""

  def fullname(f, s) do
    "#{f} #{s}"
  end

  def max_points(current_week, activities_per_week) do
    current_week * activities_per_week
  end

  def attendance_ratio(current_week, activities_per_week, points) do
    points / max_points(current_week, activities_per_week) * 100
    |> Float.round(1)
  end
end
