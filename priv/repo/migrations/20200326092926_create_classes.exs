defmodule AttendanceApp.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :title, :string

      timestamps()
    end

  end
end
