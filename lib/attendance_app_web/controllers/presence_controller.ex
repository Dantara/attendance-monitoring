defmodule AttendanceAppWeb.PresenceController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Attendance
  alias AttendanceApp.Attendance.Presence

  def index(conn, _params) do
    current_user = Pow.Plug.current_user(conn)

    presences = Attendance.user_presences(current_user)
    render(conn, "index.html", presences: presences)
  end
end
