defmodule Backend.Board.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :position, :float
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :position])
    |> validate_required([:title, :position])
  end
end
