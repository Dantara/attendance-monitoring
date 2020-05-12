defmodule AttendanceApp.Attendance do
  import Ecto.Query, warn: false
  alias AttendanceApp.Repo

  alias AttendanceApp.Attendance.Activity
  alias AttendanceApp.Accounts

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
    |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
  end

  def get_presence!(id) do
    Repo.get!(Presence, id)
    |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
  end

  def create_presence(attrs \\ %{}) do
    query = from p in Presence,
      where: p.user_id == ^attrs["user_id"]
    and p.class_id == ^attrs["class_id"]
    and p.week == ^attrs["week"]
    and p.activity_id == ^attrs["activity_id"]

    case Repo.one(query) do
      nil ->
        %Presence{}
        |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
        |> Presence.changeset(attrs)
        |> Repo.insert()
      record ->
        {:ok, record}
    end
  end

  def update_presence(%Presence{} = presence, attrs) do
    query = from p in Presence,
      where: p.user_id == ^attrs["user_id"]
    and p.class_id == ^attrs["class_id"]
    and p.week == ^attrs["week"]
    and p.activity_id == ^attrs["activity_id"]

    case Repo.one(query) do
      nil ->
        presence
        |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
        |> Presence.changeset(attrs)
        |> Repo.update()
      record ->
        {:ok, record}
    end
  end

  def delete_presence(%Presence{} = presence) do
    Repo.delete(presence)
  end

  def change_presence(%Presence{} = presence) do
    presence
    |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
    |> Presence.changeset(%{})
  end

  def user_presences(user) do
    id = user.id
    query = from p in Presence, where: p.user_id == type(^id, :integer)

    Repo.all(query)
    |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
  end

  def student_overview(user) do
    classes = Accounts.user_enrolls(user)

    Enum.map(classes, fn c -> student_overview_mapper(c, user) end)
  end

  def teacher_overview(user) do
    classes = Accounts.user_enrolls(user)

    Enum.map(classes, fn c -> teacher_overview_mapper c end)
  end

  def admin_overview do
    classes = Repo.all(Class)

    Enum.map(classes, fn c -> teacher_overview_mapper c end)
  end

  def student_class_presences(user, class_id) do
    query = from p in Presence,
      where: p.user_id == ^user.id and p.class_id == ^class_id,
      order_by: [{:asc, p.week}]

    Repo.all(query)
    |> Repo.preload([{:user, :role}, {:user, :classes}, :class, :activity])
  end

  def current_week do
    query = from p in Presence,
      select: max(p.week)

    Repo.one(query)
  end

  defp student_overview_mapper(class, user) do
    query = from p in Presence,
      where: p.user_id == ^user.id and p.class_id == ^class.id,
      select: count(p.id)

    %{id: class.id, title: class.title,
      points: Repo.one(query), activities_per_week: class.activities_per_week}
  end

  defp teacher_overview_mapper(class) do
    query = from p in Presence,
      where: p.class_id == ^class.id,
      select: count(p.id)

    %{id: class.id, title: class.title,
      points: Repo.one(query), activities_per_week: class.activities_per_week}
  end
end
