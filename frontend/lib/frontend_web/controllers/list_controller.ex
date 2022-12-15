defmodule FrontendWeb.ListController do
  use FrontendWeb, :controller

  alias Frontend.Api.Board
  alias Frontend.Api.Board.List
  alias Frontend.Api.Board.Task

  alias FrontendWeb.ApiClient.ListApiClient

  def new(conn, _params) do

    ListApiClient.new_list(conn)

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

  def delete(conn, %{"list_id" => list_id}) do
    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.delete "http://host.docker.internal:4001/api/lists/" <> list_id, headers

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

end
