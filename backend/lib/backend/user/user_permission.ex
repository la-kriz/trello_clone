defmodule Backend.Access.UserPermission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Accounts.User
  alias Backend.User.Board

  @derive {Jason.Encoder, only: [:id, :user, :permission]}

  schema "user_permissions" do
    belongs_to :user, User
    field :permission, Ecto.Enum, values: [manage: 0, write: 1, read: 2]
    belongs_to :board, Board

    timestamps()
  end

  @doc false
  def changeset(user_permission, attrs) do
    user_permission
    |> cast(attrs, [:user_id, :permission, :board_id])
    |> validate_required([:user_id, :permission, :board_id])
    |> assoc_constraint(:user)
  end
end
