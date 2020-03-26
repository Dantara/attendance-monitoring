defmodule AttendanceAppWeb.API.PresenceView do
  use AttendanceAppWeb, :view
  alias AttendanceAppWeb.API.PresenceView
  alias AttendanceAppWeb.API.UserView
  alias AttendanceAppWeb.API.ClassView
  alias AttendanceAppWeb.API.ActivityView

  def render("index.json", %{presences: presences}) do
    %{presences: render_many(presences, PresenceView, "presence.json")}
  end

  def render("show.json", %{presence: presence}) do
    %{presence: render_one(presence, PresenceView, "presence.json")}
  end

  def render("presence.json", %{presence: presence}) do
    %{id: presence.id,
      user: render_one(presence.user, UserView, "user.json"),
      class: render_one(presence.class, ClassView, "class.json"),
      activity: render_one(presence.activity, ActivityView, "activity.json"),
      week: presence.week}
  end
end
