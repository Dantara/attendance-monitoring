defmodule Attendance.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    has_one :role, Attendance.Accounts.Role

    timestamps()
  end
end
