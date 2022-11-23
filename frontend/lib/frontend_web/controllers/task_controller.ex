defmodule FrontendWeb.TaskController do
  use FrontendWeb, :controller

  alias Frontend.Api.Board
  alias Frontend.Api.Board.Task

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

  def edit(conn, %{"id" => id}) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/tasks/" <> id
    {:ok, body} = response.body |> Jason.decode()
    data = body["data"]

    task = %Task{id: data["id"], title: data["title"], description: data["description"], assigned_person: data["assigned_person"]}

    changeset = Board.change_task(task)

    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/tasks/" <> id, body, [{"Content-Type", "application/json"}]

    index(conn, %{})
  end

  def delete(conn, %{"id" => id}) do
    {:ok, response} = HTTPoison.delete "http://host.docker.internal:4001/api/tasks/" <> id

    index(conn, %{})
  end

end
