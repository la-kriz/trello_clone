defmodule FrontendWeb.TaskLive do
  use Phoenix.LiveView

  alias Decimal, as: D

  def mount(_params, _session, socket) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/lists"
    {:ok, list_body} = response.body |> Jason.decode()

    data = list_body["data"]

    {:ok, assign(socket, :tasks, data)}
  end

  def render(assigns) do
    FrontendWeb.TaskView.render("index.html", assigns)
  end

  def handle_event("edit_list_title", %{"list_id" => list_id, "new_title" => new_title_param}, socket) do
      list_params = %{"title" => new_title_param}
      body = Jason.encode! %{"list" => list_params}

      {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id,
                                      body, [{"Content-Type", "application/json"}]

      {:noreply, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) do

    before_task_position = D.new(before_task_position)
    after_task_position = D.new(after_task_position)

    new_position_param = D.div(D.add(before_task_position, after_task_position), 2)

    task_params = %{"position" => D.to_string(new_position_param)}
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> current_task_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

end