defmodule AttendanceApp.Attendance.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
