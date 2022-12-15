defmodule BackendWeb.ListController do
  use BackendWeb, :controller

  alias Backend.Board
  alias Backend.Board.List

  action_fallback BackendWeb.FallbackController

  def index(conn, %{"board_id" => board_id}) do
    lists = Board.list_lists(board_id)
    render(conn, "index.json", lists: lists)
  end

  def new(conn, _params) do
    {:ok, changeset} = Board.create_list(%{title: "No title set...", position: System.os_time(:second), tasks: []})

    render(conn, "show.json" , list: changeset)
  end

  def create(conn, %{"list" => list_params}) do
    with {:ok, %List{} = list} <- Board.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Board.get_list!(id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Board.get_list!(id)

    with {:ok, %List{} = list} <- Board.update_list(list, list_params) do
      conn
      |> put_status(200)
      |> text("List updated successfully.")
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Board.get_list!(id)

    with {:ok, %List{}} <- Board.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
