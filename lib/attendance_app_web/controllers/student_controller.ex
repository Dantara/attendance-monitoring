defmodule AttendanceAppWeb.StudentController do
  use AttendanceAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def enroll(conn, _params) do
    render(conn, "enroll.html")
  end
end
