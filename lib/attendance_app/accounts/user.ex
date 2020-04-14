defmodule AttendanceApp.Accounts.User do
  import Ecto.Changeset
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias AttendanceApp.Accounts

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    belongs_to :role, Accounts.Role
    has_many :presences, AttendanceApp.Attendance.Presence
    many_to_many :classes, AttendanceApp.Attendance.Class, join_through: "enrollments"

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name, :role_id])
    |> assoc_constraint(:role)
    |> validate_required([:first_name, :last_name])
  end

  def changeset_update_classes(user, classes) do
    user
    |> cast(%{}, [:id])
    |> put_assoc(:classes, classes)
  end
end
