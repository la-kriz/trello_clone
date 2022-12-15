defmodule BackendWeb.BoardView do
  use BackendWeb, :view
  alias BackendWeb.BoardView

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{id: board.id,
      title: board.title}
  end

  def render("board_with_permission.json", %{board_with_permission: board_with_permission}) do
    %{id: board_with_permission.id,
      title: board_with_permission.title,
      permission: board_with_permission.permission
    }
  end
end
