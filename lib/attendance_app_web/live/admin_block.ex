defmodule AttendanceAppWeb.Live.AdminBlock do
  use Phoenix.LiveView
  alias AttendanceAppWeb.AdminView
  alias AttendanceApp.Attendance
  alias AttendanceApp.Accounts

  @roles [%{value: "student", text: "Student"},
          %{value: "teacher", text: "Teacher"}]

  def render(assigns) do
    Phoenix.View.render(AdminView, "block.html", assigns)
  end

  def mount(_params, session, socket) do
    blocked = Accounts.blocked_students
    not_blocked = Accounts.not_blocked_students

    {:ok, assign(socket, %{roles: @roles, role: "student",
                           blocked: blocked, not_blocked: not_blocked})}
  end

  def handle_event("select_role", %{"role" => "student"}, socket) do
    blocked = Accounts.blocked_students
    not_blocked = Accounts.not_blocked_students

    {:noreply, assign(socket, %{role: "student",
                                blocked: blocked, not_blocked: not_blocked})}
  end

  def handle_event("select_role", %{"role" => "teacher"}, socket) do
    blocked = Accounts.blocked_teachers
    not_blocked = Accounts.not_blocked_teachers

    {:noreply, assign(socket, %{role: "teacher",
                                blocked: blocked, not_blocked: not_blocked})}
  end

  def handle_event("block", %{"user_id" => user_id}, socket) do
    {user_id, _} = Integer.parse(user_id)

    Accounts.block_user_by_id(user_id)

    role = socket.assigns.role

    {blocked, not_blocked} =
    if (role == "student") do
      {Accounts.blocked_students, Accounts.not_blocked_students}
    else
      {Accounts.blocked_teachers, Accounts.not_blocked_teachers}
    end

    {:noreply, assign(socket, %{blocked: blocked, not_blocked: not_blocked})}
  end

  def handle_event("unblock", %{"user_id" => user_id}, socket) do
    {user_id, _} = Integer.parse(user_id)

    Accounts.unblock_user_by_id(user_id)

    role = socket.assigns.role

    {blocked, not_blocked} =
    if (role == "student") do
      {Accounts.blocked_students, Accounts.not_blocked_students}
    else
      {Accounts.blocked_teachers, Accounts.not_blocked_teachers}
    end

    {:noreply, assign(socket, %{blocked: blocked, not_blocked: not_blocked})}
  end
end
