defmodule Backend.Repo.Migrations.TasksAddPositionColumn do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :position, :float
    end
  end
end
