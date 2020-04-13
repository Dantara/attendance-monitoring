defmodule AttendanceApp.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :user_id, references(:users, on_delete: :nothing)
      add :class_id, references(:classes, on_delete: :nothing)

      timestamps()
    end

    create index(:enrollments, [:user_id])
    create index(:enrollments, [:class_id])
  end
end
