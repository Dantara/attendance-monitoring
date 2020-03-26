defmodule AttendanceApp.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :title, :string

      timestamps()
    end

  end
end
