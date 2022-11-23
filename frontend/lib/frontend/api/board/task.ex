defmodule Frontend.Api.Board.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :assigned_person, :string
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assigned_person])
    |> validate_required([:title, :description, :assigned_person])
  end
end
