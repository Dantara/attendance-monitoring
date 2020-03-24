defmodule Attendance.Accounts.User do
  import Ecto.Changeset
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    has_one :role, Attendance.Accounts.Role

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
