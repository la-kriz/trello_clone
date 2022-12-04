defmodule Backend.Tasks.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Board.Task

  @derive {Jason.Encoder, only: [:id, :content]}

  schema "comments" do
    field :content, :string
    belongs_to :task, Task

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :task_id])
    |> validate_required([:content, :task_id])
    |> assoc_constraint(:task)
  end
end
