defmodule AttendanceApp.Repo.Migrations.CreatePresences do
  use Ecto.Migration

  def change do
    create table(:presences) do
      add :user_id, references(:users), null: false
      add :class_id, references(:classes), null: false
      add :activity_id, references(:activities), null: false
      add :week, :integer

      timestamps()
    end

  end
end
