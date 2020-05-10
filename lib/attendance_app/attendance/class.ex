defmodule AttendanceApp.Attendance.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :title, :string
    has_many :presences, AttendanceApp.Attendance.Presence
    many_to_many :users, AttendanceApp.Accounts.User, join_through: "enrollments"
    field :activities_per_week, :integer, default: 3

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:title, :activities_per_week])
    |> validate_required([:title])
  end
end
