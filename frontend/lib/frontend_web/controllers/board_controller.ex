defmodule FrontendWeb.BoardController do
  use FrontendWeb, :controller

  alias FrontendWeb.ApiClient.BoardApiClient

  def index(conn, _params) do

    boards = BoardApiClient.get_boards_by_user(conn)

    csrf_token = Phoenix.Controller.get_csrf_token()

    render(conn, "index.html", boards: boards, csrf_token: csrf_token)
  end

  def show(conn, %{"board_id" => board_id, "board_title" => board_title}) do

    user_id = Integer.to_string(get_session(conn, :user_id))

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/permissions/users/" <> user_id <> "/boards/" <> board_id, headers
    {:ok, permission_body} = response.body |> Jason.decode()

    permission = permission_body["data"]

    conn = put_session(conn, :board_id, board_id)
    conn = put_session(conn, :board_title, board_title)
    conn = put_session(conn, :permission, permission["permission"])

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

  def show(conn, %{}) do

    redirect(conn, to: Routes.board_path(conn, :index))
  end

  def create(conn, %{"board_title" => board_title}) do

    new_board = BoardApiClient.create_board(conn, %{"board_title" => board_title})

    conn = put_session(conn, :board_id, Integer.to_string(new_board["id"]))
    conn = put_session(conn, :board_title, board_title)
    conn = put_session(conn, :permission, new_board["permission"])

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive, board_title))
  end

end
