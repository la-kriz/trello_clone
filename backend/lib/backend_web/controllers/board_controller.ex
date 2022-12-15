defmodule BackendWeb.BoardController do
  use BackendWeb, :controller

  alias Backend.User
  alias Backend.Access

  action_fallback BackendWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    boards = User.get_boards_user_has_access_to(user_id)
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"title" => board_title, "owner_user_id" => owner_user_id}) do
    {:ok, board} = User.create_board(%{"title" => board_title, "owner_user_id" => owner_user_id})

    {:ok, permission} = Access.create_user_permission %{"user_id" => owner_user_id, "permission" => "manage", "board_id" => board.id}

    board_with_permission = %{id: board.id, title: board.title, permission: permission.permission}

    render(conn, "board_with_permission.json", board_with_permission: board_with_permission)
  end
end
