defmodule AttendanceApp.Accounts do
  import Ecto.Query, warn: false
  alias AttendanceApp.Repo

  alias AttendanceApp.Accounts.Role
  alias AttendanceApp.Accounts.Enrollment
  alias AttendanceApp.Attendance.Class
  alias AttendanceApp.Accounts.User

  def get_user!(id), do: Repo.get!(User, id)

  def list_students do
    query = from u in User,
      join: r in assoc(u, :role),
      where: r.title == "Student"

    Repo.all(query)
    |> Repo.preload([:role, :classes])
  end

  def list_teachers do
    query = from u in User,
      join: r in assoc(u, :role),
      where: r.title == "Teacher"

    Repo.all(query)
    |> Repo.preload([:role, :classes])
  end

  def list_roles do
    Repo.all(Role)
  end

  def get_role!(id), do: Repo.get!(Role, id)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  def change_role(%Role{} = role) do
    Role.changeset(role, %{})
  end

  def get_admin_role do
    query = from r in Role,
      where: r.title == "Administrator"

    Repo.one(query)
  end

  def roles_without_admin do
    query = from r in Role,
      where: r.title != "Administrator"

    Repo.all(query)
  end

  def user_enrolls(user) do
    user_enrolls_query =
      from u in User,
      where: u.id == ^user.id,
      join: c in assoc(u, :classes),
      select: %{id: c.id, title: c.title,
                activities_per_week: c.activities_per_week},
      order_by: [{:asc, c.title}]

    Repo.all(user_enrolls_query)
  end

  def user_not_enrolls(user) do
    user_enrolls_query =
      from u in User,
      where: u.id == ^user.id,
      join: c in assoc(u, :classes),
      select: %{id: c.id, title: c.title,
                activities_per_week: c.activities_per_week}

    all_classes =
      from c in Class,
      select: %{id: c.id, title: c.title}

    sorted = except(all_classes, ^user_enrolls_query)
    from s in subquery(sorted),
      order_by: [{:asc, :title}]

    Repo.all(sorted)
  end

  def enroll_user(user, class_id) do
    query = from e in Enrollment,
      where: e.user_id == ^user.id and e.class_id == ^class_id

    if not Repo.exists?(query) do
      params = %{user_id: user.id, class_id: class_id}

      Enrollment.changeset(%Enrollment{}, params)
      |> Repo.insert()
    end
  end

  def unenroll_user(user, class_id) do
    query = from e in Enrollment,
      where: e.user_id == ^user.id and e.class_id == ^class_id

    Repo.delete_all(query)
  end

  def course_students(class_id) do
    users = from u in User,
      join: c in assoc(u, :classes),
      where: c.id == ^class_id

    staff = from u in User,
      join: c in assoc(u, :classes),
      join: r in assoc(u, :role),
      where: r.title == "Administrator" or r.title == "Teacher"

    students = except(users, ^staff)
    from s in subquery(students),
      order_by: [{:asc, :title}]

    Repo.all(students)
    |> Repo.preload([:role, :classes])
  end

  def block_user_by_id(user_id) do
    params = %{blocked: true}

    user = get_user!(user_id)

    User.changeset_verifing(user, params)
    |> Repo.update()
  end

  def unblock_user_by_id(user_id) do
    params = %{blocked: false}

    user = get_user!(user_id)

    User.changeset_verifing(user, params)
    |> Repo.update()
  end

  def blocked_students do
    query = from u in User,
      join: r in assoc(u, :role),
      where: u.blocked == true and r.title == "Student"

    Repo.all(query)
  end

  def not_blocked_students do
    query = from u in User,
      join: r in assoc(u, :role),
      where: u.blocked == false and r.title == "Student"

    Repo.all(query)
  end

  def blocked_teachers do
    query = from u in User,
      join: r in assoc(u, :role),
      where: u.blocked == true and r.title == "Teacher"

    Repo.all(query)
  end

  def not_blocked_teachers do
    query = from u in User,
      join: r in assoc(u, :role),
      where: u.blocked == false and r.title == "Teacher"

    Repo.all(query)
  end
end
