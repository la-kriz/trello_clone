defmodule FrontendWeb.ApiClient.BoardApiClient do
  import Plug.Conn, only: [get_session: 2]

  def get_boards_by_user(conn) do
    user_id = Integer.to_string(get_session(conn, :user_id))

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/boards/users/" <> user_id, headers
    {:ok, boards_body} = response.body |> Jason.decode()

    boards_body["data"]
  end

end
