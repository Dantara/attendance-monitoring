defmodule AttendanceAppWeb.TeacherController do
  use AttendanceAppWeb, :controller
  alias AttendanceApp.Accounts
  alias AttendanceApp.Attendance

  def index(conn, _params) do
    current_user = Pow.Plug.current_user(conn)
    enrolls = Accounts.user_enrolls(current_user)
    current_week = Attendance.current_week

    live_render(conn, AttendanceAppWeb.Live.TeacherStatistic,
      session: %{"user" => current_user, "classes" => enrolls,
                 "current_week" => current_week})
  end

  def enroll(conn, _params) do
    current_user = Pow.Plug.current_user(conn)

    enrolls = Accounts.user_enrolls(current_user)
    not_enrolls = Accounts.user_not_enrolls(current_user)

    render(conn, "enroll.html", enrolls: enrolls, not_enrolls: not_enrolls)
  end

  def enroll_to_class(conn, %{"id" => class_id}) do
    current_user = Pow.Plug.current_user(conn)

    {class_id, _} = Integer.parse(class_id)
    Accounts.enroll_user(current_user, class_id)

    enrolls = Accounts.user_enrolls(current_user)
    not_enrolls = Accounts.user_not_enrolls(current_user)

    render(conn, "enroll.html", enrolls: enrolls, not_enrolls: not_enrolls)
  end

  def unenroll_to_class(conn, %{"id" => class_id}) do
    current_user = Pow.Plug.current_user(conn)

    {class_id, _} = Integer.parse(class_id)
    Accounts.unenroll_user(current_user, class_id)

    enrolls = Accounts.user_enrolls(current_user)
    not_enrolls = Accounts.user_not_enrolls(current_user)

    render(conn, "enroll.html", enrolls: enrolls, not_enrolls: not_enrolls)
  end
end
