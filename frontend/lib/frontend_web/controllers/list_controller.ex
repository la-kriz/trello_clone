defmodule FrontendWeb.ListController do
  use FrontendWeb, :controller

  alias FrontendWeb.ApiClient.ListApiClient

  def new(conn, _params) do

    ListApiClient.new_list(conn)

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

  def delete(conn, %{"list_id" => list_id}) do

    ListApiClient.delete_list(conn, %{"list_id" => list_id})

    board_title = get_session(conn, :board_title)

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

end
