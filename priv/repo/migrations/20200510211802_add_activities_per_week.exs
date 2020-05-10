defmodule AttendanceApp.Repo.Migrations.AddActivitiesPerWeek do
  use Ecto.Migration

  def change do
    alter table(:classes) do
      add :activities_per_week, :integer, default: 3
    end
  end
end
