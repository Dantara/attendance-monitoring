defmodule AttendanceAppWeb.StudentController do
  use AttendanceAppWeb, :controller

  def index(conn, _params) do
    IO.inspect conn
    render(conn, "index.html")
  end
end
