defmodule AttendanceAppWeb.API.ClassView do
  use AttendanceAppWeb, :view
  alias AttendanceAppWeb.API.ClassView

  def render("index.json", %{classes: classes}) do
    %{classes: render_many(classes, ClassView, "class.json")}
  end

  def render("show.json", %{class: class}) do
    %{class: render_one(class, ClassView, "class.json")}
  end

  def render("class.json", %{class: class}) do
    %{id: class.id,
      title: class.title,
      activities_per_week: class.activities_per_week}
  end
end
