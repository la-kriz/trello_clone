defmodule BackendWeb.TaskController do
  use BackendWeb, :controller

  alias Backend.Board
  alias Backend.Board.Task
  alias Backend.Board.List

  action_fallback BackendWeb.FallbackController

  def index(conn, %{"list_id" => list_id}) do
    tasks = Board.list_tasks(String.to_integer(list_id))
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    task_params = Map.put(task_params, "list_id", task_params["list_id"])
    task_params = Map.put(task_params, "position", :os.system_time(:millisecond))

    with {:ok, %Task{} = task} <- Board.create_task(task_params) do
      conn
      |> put_status(:created)
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Board.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Board.get_task!(id)

    with {:ok, %Task{} = task} <- Board.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Board.get_task!(id)

    with {:ok, %Task{}} <- Board.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
