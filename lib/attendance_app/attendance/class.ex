defmodule AttendanceApp.Attendance.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
