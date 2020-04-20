defmodule AttendanceAppWeb.Live.AdminEnroll do
  use Phoenix.LiveView, view: AttendanceAppWeb.AdminView
  alias AttendanceAppWeb.AdminView
  alias AttendanceApp.Attendance
  alias AttendanceApp.Accounts

  @roles [%{value: "student", text: "Student"},
          %{value: "teacher", text: "Teacher"}]

  def render(assigns) do
    Phoenix.View.render(AdminView, "enroll.html", assigns)
  end

  def mount(_params, session, socket) do
    students = Accounts.list_students
    teachers = Accounts.list_teachers

    enrolls = students |> first_el |> get_enrolls
    not_enrolls = students |> first_el |> get_not_enrolls

    {:ok, assign(socket, %{roles: @roles, role: "student", students: students,
                           student_id: first_id(students),
                           teachers: teachers,
                           teacher_id: first_id(teachers),
                           enrolls: enrolls, not_enrolls: not_enrolls})}
  end

  def handle_event("select_role", %{"role" => "student"}, socket) do
    students = socket.assigns.students

    enrolls = students |> first_el |> get_enrolls
    not_enrolls = students |> first_el |> get_not_enrolls

    {:noreply, assign(socket, %{role: "student",
                                enrolls: enrolls, not_enrolls: not_enrolls})}
  end

  def handle_event("select_role", %{"role" => "teacher"}, socket) do
    teachers = socket.assigns.teachers

    enrolls = teachers |> first_el |> get_enrolls
    not_enrolls = teachers |> first_el |> get_not_enrolls

    {:noreply, assign(socket, %{role: "teacher",
                                enrolls: enrolls, not_enrolls: not_enrolls})}
  end


  def handle_event("select_student", %{"student" => student_id}, socket) do
    user = get_user(student_id)

    enrolls = user |> get_enrolls
    not_enrolls = user |> get_not_enrolls

    {:noreply, assign(socket, %{student_id: student_id,
                                enrolls: enrolls, not_enrolls: not_enrolls})}
  end

  def handle_event("select_teacher", %{"teacher" => teacher_id}, socket) do
    user = get_user(teacher_id)

    enrolls = user |> get_enrolls
    not_enrolls = user |> get_not_enrolls

    {:noreply, assign(socket, %{teacher_id: teacher_id,
                                enrolls: enrolls, not_enrolls: not_enrolls})}
  end

  def handle_event("enroll", %{"class_id" => class_id}, socket) do
    {class_id, _} = Integer.parse(class_id)

    student_id = socket.assigns.student_id
    teacher_id = socket.assigns.teacher_id

    user_id = if (socket.assigns.role == "student"), do: student_id, else: teacher_id
    user = get_user(user_id)

    Accounts.enroll_user(user, class_id)
    enrolls = user |> get_enrolls
    not_enrolls = user |> get_not_enrolls

    {:noreply, assign(socket, %{enrolls: enrolls, not_enrolls: not_enrolls})}
  end

  def handle_event("unenroll", %{"class_id" => class_id}, socket) do
    {class_id, _} = Integer.parse(class_id)

    student_id = socket.assigns.student_id
    teacher_id = socket.assigns.teacher_id

    user_id = if (socket.assigns.role == "student"), do: student_id, else: teacher_id
    user = get_user(user_id)

    Accounts.unenroll_user(user, class_id)
    enrolls = user |> get_enrolls
    not_enrolls = user |> get_not_enrolls

    {:noreply, assign(socket, %{enrolls: enrolls, not_enrolls: not_enrolls})}
  end

  defp first_id([h | _]), do: h.id
  defp first_id(_), do: nil

  defp first_el([h | _]), do: h
  defp first_el(_), do: nil

  defp get_enrolls(nil), do: []
  defp get_enrolls(user), do: Accounts.user_enrolls(user)

  defp get_not_enrolls(nil), do: []
  defp get_not_enrolls(user), do: Accounts.user_not_enrolls(user)

  defp get_user(nil), do: []
  defp get_user(id), do: Accounts.get_user!(id)
end
