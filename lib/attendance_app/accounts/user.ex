defmodule AttendanceApp.Accounts.User do
  import Ecto.Changeset
  import Ecto.Query
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema
  alias AttendanceApp.Accounts
  alias AttendanceApp.Accounts.Role
  alias AttendanceApp.Repo

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    belongs_to :role, Accounts.Role
    has_many :presences, AttendanceApp.Attendance.Presence
    many_to_many :classes, AttendanceApp.Attendance.Class, join_through: "enrollments"
    field :blocked, :boolean

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

  def changeset_verifing(user, params) do
    user
    |> cast(params, [:blocked])
    |> validate_required([:blocked])
  end

  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    role_id = Repo.one(from r in Role, where: r.title == "Student", select: r.id)

    %{"given_name" => first_name, "family_name" => last_name} = attrs

    Map.merge(user_or_changeset,
      %{first_name: first_name, last_name: last_name, role_id: role_id})
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
  end
end
