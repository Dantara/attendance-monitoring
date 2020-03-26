defmodule AttendanceApp.Attendance.Presence do
  use Ecto.Schema
  import Ecto.Changeset
  alias AttendanceApp.Attendance
  alias AttendanceApp.Accounts

  schema "presences" do
    belongs_to :user, Accounts.User
    belongs_to :class, Attendance.Class
    belongs_to :activity, Attendance.Activity
    field :week, :integer

    timestamps()
  end

  @doc false
  def changeset(presence, attrs) do
    presence
    |> cast(attrs, [:week, :user_id, :class_id, :activity_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:class)
    |> assoc_constraint(:activity)
    |> validate_required([:week])
  end
end
