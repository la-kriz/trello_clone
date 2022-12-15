defmodule Backend.User do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.User.Board
  alias Backend.Access.UserPermission

  def get_boards_user_has_access_to(user_id) do
    base_query = from(boards in Board)
    boards_in_user_permissions_filtered_by_user_id = from(
      board in base_query,
      join: user_permission in UserPermission,
      on: user_permission.board_id == board.id,
      where: user_permission.user_id == ^user_id
    )
    Repo.all(boards_in_user_permissions_filtered_by_user_id)
  end

  def get_board!(id), do: Repo.get!(Board, id)

  def create_board(attrs \\ %{}) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

end
