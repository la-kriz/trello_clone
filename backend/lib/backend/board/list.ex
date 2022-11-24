defmodule Backend.Board.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Board.Task

  @derive {Jason.Encoder, only: [:id, :title, :position, :tasks]}

  schema "lists" do
    field :position, :float
    field :title, :string
    has_many :tasks, Task

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :position])
    |> cast_assoc(:tasks)
    |> validate_required([:title, :position])
  end
end
