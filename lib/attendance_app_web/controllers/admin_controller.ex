defmodule AttendanceAppWeb.AdminController do
  use AttendanceAppWeb, :controller
  alias AttendanceApp.Attendance

  def index(conn, _params) do
    classes = Attendance.list_classes

    live_render(conn, AttendanceAppWeb.Live.AdminStatistic,
      session: %{"classes" => classes})
  end

  def enroll(conn, _params) do
    live_render(conn, AttendanceAppWeb.Live.AdminEnroll,
    session: %{})
  end

  def verifing(conn, _params) do
    live_render(conn, AttendanceAppWeb.Live.AdminVerify,
      session: %{})
  end
end
