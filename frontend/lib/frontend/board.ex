defmodule Frontend.Board do
  @moduledoc """
  The Board context.
  """

  import Ecto.Query, warn: false
  alias Frontend.Repo

  alias Frontend.Board.Task

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
