defmodule Backend.Repo.Migrations.ListsAddBoardIdColumn do
  use Ecto.Migration

  def change do
    alter table("lists") do
      add :board_id, references(:boards, on_delete: :delete_all), default: 1
    end

    alter table("lists") do
      modify :board_id,
             references(:boards, on_delete: :delete_all),
             null: false,
             from: references(:boards, on_delete: :delete_all), default: 1
    end
  end
end
