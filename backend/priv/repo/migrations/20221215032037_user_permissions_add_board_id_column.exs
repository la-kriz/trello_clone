defmodule Backend.Repo.Migrations.UserPermissionsAddBoardIdColumn do
  use Ecto.Migration

  def change do
    alter table("user_permissions") do
      add :board_id, references(:boards, on_delete: :delete_all), default: 1
    end

    alter table("user_permissions") do
      modify :board_id,
             references(:boards, on_delete: :delete_all),
             null: false,
             from: references(:boards, on_delete: :delete_all), default: 1
    end
  end
end
