defmodule Backend.User.Board do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title]}

  schema "boards" do
    field :title, :string
    field :owner_user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :owner_user_id])
    |> validate_required([:title, :owner_user_id])
    |> unique_constraint(:title)
  end
end
