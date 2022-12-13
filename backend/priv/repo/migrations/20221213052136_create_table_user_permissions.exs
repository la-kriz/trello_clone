defmodule Backend.Repo.Migrations.CreateTableUserPermissions do
  use Ecto.Migration

  def change do
    create table(:user_permissions) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :permission, :integer, null: false

      timestamps()
    end

    create index(:user_permissions, [:user_id])
  end
end
