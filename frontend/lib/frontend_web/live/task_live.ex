defmodule FrontendWeb.TaskLive do
  use Phoenix.LiveView

  alias Decimal, as: D

  def mount(_params, _session, socket) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/lists"
    {:ok, list_body} = response.body |> Jason.decode()

    data = list_body["data"]

    socket = assign(socket, :lists, data)
    socket = assign(socket, token: Phoenix.Controller.get_csrf_token())

    {:ok, socket}
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
  }, socket) when is_nil(before_task_position) and is_nil(after_task_position) do

    new_position_param = D.new(:os.system_time(:millisecond))

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> current_task_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) when is_nil(before_task_position) do

    new_position_param = D.sub(after_task_position, D.new(50))

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> current_task_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_task", %{
    "list_id" => list_id,
    "current_task_id" => current_task_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) when is_nil(after_task_position) do

    new_position_param = D.add(before_task_position, D.new(50))

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> current_task_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
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

    task_params = %{"position" => D.to_string(new_position_param), "list_id" => list_id}
    body = Jason.encode! %{"task" => task_params}

    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id <> "/tasks/" <> current_task_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_list", %{
    "list_id" => list_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position
  }, socket) do

    new_position_param = D.add(before_task_position, D.new(50))

    task_params = %{"position" => D.to_string(new_position_param)}
    body = Jason.encode! %{"list" => task_params}

    IO.puts ">------------->>>>> called moving LIST at the middle, before/new position is " <> before_task_position
            <> ", " <> D.to_string(new_position_param)
    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

  def handle_event("reorder_list", %{
    "list_id" => list_id,
    "before_task_position" => before_task_position,
    "current_task_position" => current_task_position,
    "after_task_position" => after_task_position
  }, socket) do

    before_task_position = D.new(before_task_position)
    after_task_position = D.new(after_task_position)

    new_position_param = D.div(D.add(before_task_position, after_task_position), 2)

    task_params = %{"position" => D.to_string(new_position_param)}
    body = Jason.encode! %{"list" => task_params}

    IO.puts ">------------->>>>> called moving LIST at the middle, before/new/after position is " <> D.to_string(before_task_position)
            <> ", " <> D.to_string(new_position_param) <> ", "<> D.to_string(after_task_position)
    {:ok, response} = HTTPoison.put "http://host.docker.internal:4001/api/lists/" <> list_id,
                                    body, [{"Content-Type", "application/json"}]

    {:reply, %{"new_position" => D.to_string(new_position_param)}, socket}
  end

end