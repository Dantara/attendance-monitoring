defmodule AttendanceAppWeb.Live.TeacherStatistic do
  use Phoenix.LiveView
  alias AttendanceAppWeb.TeacherView
  alias AttendanceApp.Attendance
  alias AttendanceApp.Accounts

  @modes [%{value: "overview", text: "Overview"},
          %{value: "detailed", text: "Detailed view"}]

  def render(assigns) do
    Phoenix.View.render(TeacherView, "index.html", assigns)
  end

  def mount(_params, session, socket) do
    classes = session["classes"]
    user = session["user"]
    current_week = session["current_week"]

    {:ok, update_socket(socket, "overview.html", user, "overview", classes,
        nil, nil, nil, [], [], current_week)}

  end

  def handle_event("select_mode", %{"mode" => "overview"}, socket) do
    right_render = "overview.html"
    user = socket.assigns.user
    mode = "overview"
    classes = socket.assigns.classes
    class_id = socket.assigns.class_id
    student_id = socket.assigns.student_id
    students = socket.assigns.students
    overview = socket.assigns.overview
    detailed = socket.assigns.detailed
    current_week = socket.assigns.current_week

    {:noreply, update_socket(socket, right_render, user, mode, classes,
        class_id, students, student_id, overview, detailed, current_week)}

  end

  def handle_event("select_mode", %{"mode" => "detailed"}, socket) do
    right_render = "detailed_view.html"
    user = socket.assigns.user
    mode = "detailed"
    classes = socket.assigns.classes
    class_id = socket.assigns.class_id
    student_id = socket.assigns.student_id
    students = socket.assigns.students
    overview = socket.assigns.overview
    detailed = socket.assigns.detailed
    current_week = socket.assigns.current_week

    {:noreply, update_socket(socket, right_render, user, mode, classes,
        class_id, students, student_id, overview, detailed, current_week)}

  end

  def handle_event("select_class", %{"class" => class_id}, socket) do
    right_render = socket.assigns.right_render
    user = socket.assigns.user
    mode = socket.assigns.mode
    classes = socket.assigns.classes
    student_id = socket.assigns.student_id
    students = socket.assigns.students
    overview = socket.assigns.overview
    detailed = socket.assigns.detailed
    current_week = socket.assigns.current_week

    {class_id, _} = Integer.parse(class_id)

    {:noreply, update_socket(socket, right_render, user, mode, classes,
        class_id, students, student_id, overview, detailed, current_week)}

  end

  def handle_event("select_student", %{"student" => student_id}, socket) do
    right_render = socket.assigns.right_render
    user = socket.assigns.user
    mode = socket.assigns.mode
    classes = socket.assigns.classes
    class_id = socket.assigns.class_id
    students = socket.assigns.students
    overview = socket.assigns.overview
    detailed = socket.assigns.detailed
    current_week = socket.assigns.current_week

    {:noreply, update_socket(socket, right_render, user, mode, classes,
        class_id, students, student_id, overview, detailed, current_week)}
  end

  defp update_socket(socket, right_render, user, mode, classes,
    class_id, students, student_id, overview, detailed, current_week) do

    case {classes, class_id, students, student_id, overview, detailed} do
      {[f_class | _], nil, [f_student | _], nil, _, _} ->
        class_id = f_class.id
        student_id = f_student.id
        overview = Attendance.teacher_overview user
        detailed = Attendance.student_class_presences f_student, class_id

        set_socket(socket, right_render, user, mode, classes,
          class_id, students, student_id, overview, detailed, current_week)

      {[f_class | _], nil, nil, _, _, _} ->
        class_id = f_class.id
        students = Accounts.course_students class_id

        update_socket(socket, right_render, user, mode, classes,
          class_id, students, student_id, overview, detailed, current_week)

      {[_class | _], _, [f_student | _], nil, _, _} ->
        student_id = f_student.id
        overview = Attendance.teacher_overview user
        detailed = Attendance.student_class_presences f_student, class_id

        set_socket(socket, right_render, user, mode, classes,
          class_id, students, student_id, overview, detailed, current_week)

      {[_class | _], _, [_student | _], _, _, _} ->
        overview = Attendance.teacher_overview user
        student = Accounts.get_user!(student_id)
        detailed = Attendance.student_class_presences student, class_id

        set_socket(socket, right_render, user, mode, classes,
          class_id, students, student_id, overview, detailed, current_week)

      {[f_class | _], _, [], _, _, _} ->
        overview = Attendance.teacher_overview user
        students = Accounts.course_students class_id
        student_id = first_id students
        detailed = get_detailed student_id, class_id

        set_socket(socket, right_render, user, mode, classes,
          class_id, students, student_id, overview, detailed, current_week)

      _ ->
        set_socket(socket, right_render, user, mode, classes,
          class_id, students, student_id, overview, detailed, current_week)
    end
  end

  defp set_socket(socket, right_render, user, mode, classes,
    class_id, students, student_id, overview, detailed, current_week) do

    assign(socket, %{right_render: right_render, user: user, modes: @modes,
                     mode: mode, classes: classes, class_id: class_id,
                     students: students, student_id: student_id,
                     overview: overview, detailed: detailed,
                     current_week: current_week})
  end

  defp first_id([l | _]), do: l.id
  defp first_id(_), do: nil

  defp get_detailed(nil, _), do: []
  defp get_detailed(student_id, class_id) do
    student = Accounts.get_user!(student_id)
    Attendance.student_class_presences student, class_id
  end
end
