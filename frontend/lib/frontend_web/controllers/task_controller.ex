defmodule FrontendWeb.TaskController do
  use FrontendWeb, :controller

  alias Frontend.Api.Board
  alias Frontend.Api.Board.Task

  alias FrontendWeb.ApiClient.TaskApiClient

  def new(conn, %{"list_id" => list_id}) do
    changeset = Board.change_task(%Task{})

    board_title = get_session(conn, :board_title)

    render(conn, "new.html" , changeset: changeset, list_id: list_id, board_title: board_title)
  end

  def create(conn, %{"task" => task_params, "list_id" => list_id}) do

    TaskApiClient.create_task(conn, %{"task" => task_params, "list_id" => list_id})

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "task" => task_params}) do

    access_token = get_session(conn, :access_token)

    TaskApiClient.update_task(%{"list_id" => list_id, "id" => id, "task" => task_params, "access_token" => access_token})

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

  def delete(conn, %{"id" => id}) do

    TaskApiClient.delete_task(conn, %{"id" => id})

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

end
