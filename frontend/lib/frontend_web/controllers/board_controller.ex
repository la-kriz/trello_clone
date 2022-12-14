defmodule FrontendWeb.BoardController do
  use FrontendWeb, :controller

  def index(conn, _params) do

    user_id = Integer.to_string(get_session(conn, :user_id))

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/boards/users/" <> user_id, headers
    {:ok, board_body} = response.body |> Jason.decode()

    data = board_body["data"]

    render(conn, "index.html", boards: data)
  end

end
