defmodule Backend.Board.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Board.List

  @derive {Jason.Encoder, only: [:id, :title, :description, :assigned_person, :position]}

  schema "tasks" do
    field :position, :float
    field :assigned_person, :string
    field :description, :string
    field :title, :string
    belongs_to :list, List

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assigned_person, :position, :list_id])
    |> validate_required([:title, :description, :assigned_person, :position])
    |> assoc_constraint(:list)
  end
end
