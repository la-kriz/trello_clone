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

end