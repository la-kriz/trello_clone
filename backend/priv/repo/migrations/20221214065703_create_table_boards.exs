defmodule Backend.Repo.Migrations.CreateTableBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :title, :string, null: false
      add :owner_user_id, references(:users), null: false

      timestamps()
    end

    create unique_index(:boards, [:title])
  end
end
