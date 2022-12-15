defmodule BackendWeb.BoardController do
  use BackendWeb, :controller

  alias Backend.User

  action_fallback BackendWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    boards = User.get_boards_user_has_access_to(user_id)
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"title" => board_title, "owner_user_id" => owner_user_id}) do
    board = User.create_board(%{"title" => board_title, "owner_user_id" => owner_user_id})

    render(conn, "show.json", board: board)
  end
end
