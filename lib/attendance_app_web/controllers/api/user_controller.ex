defmodule AttendanceAppWeb.API.UserController do
  use AttendanceAppWeb, :controller

  alias AttendanceApp.Accounts.User
  alias AttendanceApp.Accounts
  alias Pow.Plug
  alias AttendanceApp.Repo

  def show(conn, _params) do
    current_user =
      Pow.Plug.current_user(conn)
      |> Repo.preload([:role, :classes])

    render(conn, "show.json", user: current_user)
  end

  def class_students(conn, %{"id" => id}) do
    {class_id, _} = Integer.parse(id)

    students = Accounts.course_students(class_id)

    render(conn, "students.json", students: students)
  end
end
