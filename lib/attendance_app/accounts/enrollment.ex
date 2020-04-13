defmodule AttendanceApp.Accounts.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "enrollments" do
    field :user_id, :id
    field :class_id, :id

    timestamps()
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
