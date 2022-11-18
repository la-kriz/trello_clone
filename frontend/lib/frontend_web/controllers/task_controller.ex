defmodule FrontendWeb.TaskController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/tasks"
    {:ok, body} = response.body |> Jason.decode()
    # tasks = for {key, val} <- body["data"], into: %{}, do: {String.to_atom(key), val}
    render(conn, "index.html", tasks: body["data"])
  end

  def show(conn, %{"id" => id}) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/tasks/" <> id
    {:ok, body} = response.body |> Jason.decode()
    render(conn, "show.html", task: body["data"])
  end

end
