defmodule Frontend.Api.Board.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias Frontend.Api.Board.Task

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
