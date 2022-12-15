defmodule FrontendWeb.ApiClient.ListApiClient do
  import Plug.Conn, only: [get_session: 2]

  def new_list(conn) do

    board_id = get_session(conn, :board_id)

    body = Jason.encode! %{"board_id" => board_id}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/lists/new", body, headers
  end

end
