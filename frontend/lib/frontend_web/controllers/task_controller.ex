defmodule FrontendWeb.TaskController do
  use FrontendWeb, :controller

  alias Frontend.Board
  alias Frontend.Board.Task

  def index(conn, _params) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/tasks"
    {:ok, body} = response.body |> Jason.decode()
    # tasks = for {key, val} <- body["data"], into: %{}, do: {String.to_atom(key), val}
    render(conn, "index.html", tasks: body["data"])
  end

  def new(conn, _params) do
    changeset = Board.change_task(%Task{})
    render(conn, "new.html" , changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.post "http://host.docker.internal:4001/api/tasks", body, [{"Content-Type", "application/json"}]

    {:ok, body} = response.body |> Jason.decode()

    index(conn, %{})

  end

  def show(conn, %{"id" => id}) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/tasks/" <> id
    {:ok, body} = response.body |> Jason.decode()
    render(conn, "show.html", task: body["data"])
  end

end
