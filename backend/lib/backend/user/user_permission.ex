defmodule Backend.User.UserPermission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Accounts.User

  @derive {Jason.Encoder, only: [:id, :user, :permission]}

  schema "user_permissions" do
    belongs_to :user, User
    field :permission, Ecto.Enum, values: [manage: 0, write: 1, read: 2]

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:user_id, :permission])
    |> validate_required([:permission])
    |> assoc_constraint(:user)
  end
end
