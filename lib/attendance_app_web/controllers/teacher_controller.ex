defmodule AttendanceAppWeb.TeacherController do
  use AttendanceAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
