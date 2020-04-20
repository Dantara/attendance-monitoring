defmodule AttendanceAppWeb.Live.AdminVerify do
  use Phoenix.LiveView
  alias AttendanceAppWeb.AdminView
  alias AttendanceApp.Attendance
  alias AttendanceApp.Accounts

  @roles [%{value: "student", text: "Student"},
          %{value: "teacher", text: "Teacher"}]

  def render(assigns) do
    Phoenix.View.render(AdminView, "verify.html", assigns)
  end

  def mount(_params, session, socket) do
    verified = Accounts.verified_students
    not_verified = Accounts.not_verified_students

    {:ok, assign(socket, %{roles: @roles, role: "student",
                           verified: verified, not_verified: not_verified})}
  end

  def handle_event("select_role", %{"role" => "student"}, socket) do
    verified = Accounts.verified_students
    not_verified = Accounts.not_verified_students

    {:noreply, assign(socket, %{role: "student",
                                verified: verified, not_verified: not_verified})}
  end

  def handle_event("select_role", %{"role" => "teacher"}, socket) do
    verified = Accounts.verified_teachers
    not_verified = Accounts.not_verified_teachers

    {:noreply, assign(socket, %{role: "teacher",
                                verified: verified, not_verified: not_verified})}
  end

  def handle_event("verify", %{"user_id" => user_id}, socket) do
    {user_id, _} = Integer.parse(user_id)

    Accounts.verify_user_by_id(user_id)

    role = socket.assigns.role

    {verified, not_verified} =
    if (role == "student") do
      {Accounts.verified_students, Accounts.not_verified_students}
    else
      {Accounts.verified_teachers, Accounts.not_verified_teachers}
    end

    {:noreply, assign(socket, %{verified: verified, not_verified: not_verified})}
  end

  def handle_event("unverify", %{"user_id" => user_id}, socket) do
    {user_id, _} = Integer.parse(user_id)

    Accounts.unverify_user_by_id(user_id)

    role = socket.assigns.role

    {verified, not_verified} =
    if (role == "student") do
      {Accounts.verified_students, Accounts.not_verified_students}
    else
      {Accounts.verified_teachers, Accounts.not_verified_teachers}
    end

    {:noreply, assign(socket, %{verified: verified, not_verified: not_verified})}
  end
end
