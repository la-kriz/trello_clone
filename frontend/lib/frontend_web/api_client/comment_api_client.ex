defmodule FrontendWeb.ApiClient.CommentApiClient do
  import Plug.Conn, only: [get_session: 2]

  def get_comments_of_task(%{"task_id" => task_id, "access_token" => access_token}) do

    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/comments?task_id=" <> task_id, headers
    {:ok, body} = response.body |> Jason.decode()

    Enum.map(body["data"], &(&1["content"]))
  end

end
