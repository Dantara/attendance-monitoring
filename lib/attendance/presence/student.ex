defmodule Attendance.Presence.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :class, :string
    field :email, :string
    field :first_name, :string
    field :group, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :email, :group, :class])
    |> validate_required([:first_name, :last_name, :email, :group, :class])
  end
end
