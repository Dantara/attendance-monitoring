defmodule AttendanceAppWeb.Live.TeacherView do
  use Phoenix.LiveView
  alias AttendanceAppWeb.StudentView
  alias AttendanceApp.Attendance

  @modes [%{value: "overview", text: "Overview"},
          %{value: "detailed", text: "Detailed view"}]

  def render(assigns) do
    Phoenix.View.render(StudentView, "index.html", assigns)
  end

  def mount(_params, session, socket) do
    classes = session["classes"]
    user = session["user"]

    overview = Attendance.teacher_overview user

    case classes do
      [first_class | _] ->
        class_id = first_class.id
        detailed = Attendance.student_class_presences user, class_id

        {:ok, assign(socket, %{right_render: "overview.html",
                               modes: @modes,
                               mode: "overview",
                               classes: classes,
                               class_id: class_id,
                               user: user,
                               overview: overview,
                               detailed: detailed})}
      _ ->
        {:ok, assign(socket, %{right_render: "overview.html",
                               modes: @modes,
                               mode: "overview",
                               classes: classes,
                               class_id: nil,
                               user: user,
                               overview: overview,
                               detailed: nil})}
    end
  end

  def handle_event("select_mode", %{"mode" => "overview"}, socket) do
    overview = Attendance.teacher_overview socket.assigns.user

    {:noreply, assign(socket, %{right_render: "overview.html",
                                mode: "overview",
                                overview: overview})}
  end

  def handle_event("select_mode", %{"mode" => "detailed"}, socket) do
    {:noreply, assign(socket, %{right_render: "detailed_view.html", mode: "detailed"})}
  end

  def handle_event("select_class", %{"class" => class_id}, socket) do
    {class_id, _} = Integer.parse(class_id)
    user = socket.assigns.user

    detailed = Attendance.student_class_presences user, class_id

    {:noreply, assign(socket, %{right_render: "detailed_view.html",
                                mode: "detailed",
                                class_id: class_id,
                                detailed: detailed})}
  end

end
