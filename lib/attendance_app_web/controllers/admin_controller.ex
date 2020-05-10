defmodule AttendanceAppWeb.AdminController do
  use AttendanceAppWeb, :controller
  alias AttendanceApp.Attendance

  def index(conn, _params) do
    classes = Attendance.list_classes
    current_week = Attendance.current_week

    live_render(conn, AttendanceAppWeb.Live.AdminStatistic,
      session: %{"classes" => classes, "current_week" => current_week})
  end

  def enroll(conn, _params) do
    live_render(conn, AttendanceAppWeb.Live.AdminEnroll,
    session: %{})
  end

  def blocking(conn, _params) do
    live_render(conn, AttendanceAppWeb.Live.AdminBlock,
      session: %{})
  end
end
