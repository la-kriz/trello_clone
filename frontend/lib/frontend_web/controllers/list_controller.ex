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

end
