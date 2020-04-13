defmodule AttendanceApp.Attendance.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :title, :string
    has_many :presences, AttendanceApp.Attendance.Presence
    many_to_many :users, AttendanceApp.Attendance.User, join_through: "enrollments"

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end