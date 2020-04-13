defmodule AttendanceApp.Attendance do
  import Ecto.Query, warn: false
  alias AttendanceApp.Repo

  alias AttendanceApp.Attendance.Activity

  def list_activities do
    Repo.all(Activity)
  end

  def get_activity!(id), do: Repo.get!(Activity, id)

  def create_activity(attrs \\ %{}) do
    %Activity{}
    |> Activity.changeset(attrs)
    |> Repo.insert()
  end

  def update_activity(%Activity{} = activity, attrs) do
    activity
    |> Activity.changeset(attrs)
    |> Repo.update()
  end

  def delete_activity(%Activity{} = activity) do
    Repo.delete(activity)
  end

  def change_activity(%Activity{} = activity) do
    Activity.changeset(activity, %{})
  end

  alias AttendanceApp.Attendance.Class

  def list_classes do
    Repo.all(Class)
  end

  def get_class!(id), do: Repo.get!(Class, id)

  def create_class(attrs \\ %{}) do
    %Class{}
    |> Class.changeset(attrs)
    |> Repo.insert()
  end

  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  def change_class(%Class{} = class) do
    Class.changeset(class, %{})
  end

  alias AttendanceApp.Attendance.Presence

  def list_presences do
    Repo.all(Presence)
    |> Repo.preload([{:user, :role}, :class, :activity])
  end

  def get_presence!(id) do
    Repo.get!(Presence, id)
    |> Repo.preload([{:user, :role}, :class, :activity])
  end

  def create_presence(attrs \\ %{}) do
    %Presence{}
    |> Repo.preload([{:user, :role}, :class, :activity])
    |> Presence.changeset(attrs)
    |> Repo.insert()
  end

  def update_presence(%Presence{} = presence, attrs) do
    presence
    |> Repo.preload([{:user, :role}, :class, :activity])
    |> Presence.changeset(attrs)
    |> Repo.update()
  end

  def delete_presence(%Presence{} = presence) do
    Repo.delete(presence)
  end

  def change_presence(%Presence{} = presence) do
    presence
    |> Repo.preload([{:user, :role}, :class, :activity])
    |> Presence.changeset(%{})
  end

  def user_presences(user) do
    id = user.id
    query = from p in Presence, where: p.user_id == type(^id, :integer)

    Repo.all(query)
    |> Repo.preload([{:user, :role}, :class, :activity])
  end
end