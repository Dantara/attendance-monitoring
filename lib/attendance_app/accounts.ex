defmodule AttendanceApp.Accounts do
  import Ecto.Query, warn: false
  alias AttendanceApp.Repo

  alias AttendanceApp.Accounts.Role
  alias AttendanceApp.Accounts.Enrollment
  alias AttendanceApp.Attendance.Class
  alias AttendanceApp.Accounts.User

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

  def user_enrolls(user) do
    # %{classes: enrolls} =
    #   user
    user_enrolls_query =
      from u in User,
      where: u.id == ^user.id,
      join: c in assoc(u, :classes),
      select: %{id: c.id, title: c.title},
      order_by: [{:asc, c.title}]
      # |> Repo.preload(:classes)

    # enrolls
    Repo.all(user_enrolls_query)
  end

  def user_not_enrolls(user) do
    user_enrolls_query =
      from u in User,
      where: u.id == ^user.id,
      join: c in assoc(u, :classes),
      select: %{id: c.id, title: c.title}

    all_classes =
      from c in Class,
      select: %{id: c.id, title: c.title}

    sorted = except(all_classes, ^user_enrolls_query)
      from s in subquery(sorted),
      order_by: [{:asc, :title}]

    Repo.all(sorted)
  end
end
