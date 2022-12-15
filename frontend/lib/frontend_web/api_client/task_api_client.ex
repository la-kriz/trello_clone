defmodule FrontendWeb.ApiClient.TaskApiClient do
  import Plug.Conn, only: [get_session: 2]

  def create_task(conn, %{"task" => task_params, "list_id" => list_id}) do

    body = Jason.encode! %{"task" => Map.put(task_params, :list_id, list_id)}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks",
                                      body, headers
  end

end
