defmodule FrontendWeb.ListController do
  use FrontendWeb, :controller

  alias Frontend.Api.Board
  alias Frontend.Api.Board.List
  alias Frontend.Api.Board.Task

  def index(conn, _params) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/tasks"
    {:ok, body} = response.body |> Jason.decode()
    # tasks = for {key, val} <- body["data"], into: %{}, do: {String.to_atom(key), val}
    render(conn, "index.html", tasks: body["data"])
  end

  def new(conn, _params) do
    {:ok, _response} = HTTPoison.get "http://host.docker.internal:4001/api/lists/new"

    redirect(conn, to: Routes.task_path(conn, :index))
  end

  def delete(conn, %{"list_id" => list_id}) do
    {:ok, response} = HTTPoison.delete "http://host.docker.internal:4001/api/lists/" <> list_id

    redirect(conn, to: Routes.task_path(conn, :index))
  end

end
