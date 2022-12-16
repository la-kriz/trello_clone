defmodule FrontendWeb.ApiClient.ListApiClient do
  import Plug.Conn, only: [get_session: 2]

  def get_lists_by_current_board(%{"access_token" => access_token, "board_id" => board_id}) do

    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/boards/" <> board_id <> "/lists", headers
    {:ok, list_body} = response.body |> Jason.decode()

    list_body["data"]
  end

  def update_list(%{"list_id" => list_id, "params" => list_params, "access_token" => access_token}) do

    body = Jason.encode! %{"list" => list_params}

    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id,
                                    body, headers
  end

  def new_list(conn) do

    board_id = get_session(conn, :board_id)

    body = Jason.encode! %{"board_id" => board_id}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/lists/new", body, headers
  end

  def delete_list(conn, %{"list_id" => list_id}) do

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.delete "http://host.docker.internal:4001/api/lists/" <> list_id, headers
  end
end
