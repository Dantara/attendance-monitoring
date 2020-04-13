defmodule AttendanceAppWeb.StudentController do
  use AttendanceAppWeb, :controller
  alias AttendanceApp.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def enroll(conn, _params) do
    current_user = Pow.Plug.current_user(conn)

    enrolls = Accounts.user_enrolls(current_user)
    not_enrolls = Accounts.user_not_enrolls(current_user)

    render(conn, "enroll.html", enrolls: enrolls, not_enrolls: not_enrolls)
  end
end
