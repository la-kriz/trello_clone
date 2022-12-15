defmodule FrontendWeb.ApiClient.TaskApiClient do
  import Plug.Conn, only: [get_session: 2]

  def create_task(conn, %{"task" => task_params, "list_id" => list_id}) do

    body = Jason.encode! %{"task" => Map.put(task_params, :list_id, list_id)}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks",
                                      body, headers
  end

  def update_task(conn, %{"list_id" => list_id, "id" => id, "task" => task_params}) do

    body = Jason.encode! %{"task" => task_params}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> id,
                                     body, headers
  end

  def delete_task(conn, %{"id" => id}) do

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.delete "http://host.docker.internal:4001/api/tasks/" <> id, headers
  end
end
