defmodule AttendanceApp.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :title, :string, null: false

      timestamps()
    end

  end
end
