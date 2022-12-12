defmodule FrontendWeb.TaskController do
  use FrontendWeb, :controller

  alias Frontend.Api.Board
  alias Frontend.Api.Board.Task

  def index(conn, _params) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/lists"
    {:ok, list_body} = response.body |> Jason.decode()

    data = list_body["data"]

    render(conn, "index.html", tasks: data)
  end

  def new(conn, %{"list_id" => list_id}) do
    changeset = Board.change_task(%Task{})
    render(conn, "new.html" , changeset: changeset, list_id: list_id)
  end

  def create(conn, %{"task" => task_params, "list_id" => list_id}) do
    body = Jason.encode! %{"task" => Map.put(task_params, :list_id, list_id)}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.post "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks", body, headers

    {:ok, body} = response.body |> Jason.decode()

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive))
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> id
    {:ok, body} = response.body |> Jason.decode()
    render(conn, "show.html", task: body["data"])
  end

  def edit(conn, %{"list_id" => list_id, "id" => id}) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> id
    {:ok, body} = response.body |> Jason.decode()
    data = body["data"]

    task = %Task{id: data["id"], title: data["title"], description: data["description"], assigned_person: data["assigned_person"]}

    changeset = Board.change_task(task)

    render(conn, "edit.html", task: task, changeset: changeset, list_id: list_id)
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "task" => task_params}) do
    body = Jason.encode! %{"task" => task_params}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> id,
                                    body, headers

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive))
  end

  def delete(conn, %{"id" => id}) do
    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.delete "http://host.docker.internal:4001/api/tasks/" <> id, headers

    redirect(conn, to: Routes.live_path(FrontendWeb.Endpoint, FrontendWeb.TaskLive))
  end

end
