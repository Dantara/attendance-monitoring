defmodule AttendanceApp.Repo.Migrations.ValidToBlocked do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :verified
      add :blocked, :boolean, default: false
    end

  end
end
