defmodule AttendanceAppWeb.API.ActivityView do
  use AttendanceAppWeb, :view
  alias AttendanceAppWeb.API.ActivityView

  def render("index.json", %{activities: activities}) do
    %{activities: render_many(activities, ActivityView, "activity.json")}
  end

  def render("show.json", %{activity: activity}) do
    %{activity: render_one(activity, ActivityView, "activity.json")}
  end

  def render("activity.json", %{activity: activity}) do
    %{id: activity.id,
      title: activity.title}
  end
end
