defmodule AttendanceWeb.StudentController do
  use AttendanceWeb, :controller

  alias Attendance.Presence
  alias Attendance.Presence.Student

  action_fallback AttendanceWeb.FallbackController

  def index(conn, _params) do
    students = Presence.list_students()
    render(conn, "index.json", students: students)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Presence.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Presence.get_student!(id)
    render(conn, "show.json", student: student)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Presence.get_student!(id)

    with {:ok, %Student{} = student} <- Presence.update_student(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Presence.get_student!(id)

    with {:ok, %Student{}} <- Presence.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end
end
