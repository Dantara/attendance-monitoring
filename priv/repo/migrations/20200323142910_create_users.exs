defmodule AttendanceApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :role_id, references(:roles), null: false
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
