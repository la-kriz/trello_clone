defmodule FrontendWeb.TaskLive do
  use Phoenix.LiveView

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
end