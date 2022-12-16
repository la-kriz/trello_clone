defmodule FrontendWeb.ApiClient.CommentApiClient do
  import Plug.Conn, only: [get_session: 2]

  def get_comments_of_task(%{"task_id" => task_id, "access_token" => access_token}) do

    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/comments?task_id=" <> task_id, headers
    {:ok, body} = response.body |> Jason.decode()

    Enum.map(body["data"], &(&1["content"]))
  end

  def add_comment_to_task(%{"comment_params" => comment_params, "access_token" => access_token}) do

    body = Jason.encode! %{"comment" => comment_params}

    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/comments", body, headers
  end
end
