defmodule AttendanceApp.Repo.Migrations.AddUserVerified do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :verified, :boolean, default: false
    end

  end
end
