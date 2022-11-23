defmodule Backend.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :string
      add :assigned_person, :string
      add :list_id, references(:lists), null: false

      timestamps()
    end

  end
end
