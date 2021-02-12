defmodule Frontend.API do
  use Tesla
  plug Tesla.Middleware.BaseUrl, "http://backend:4000/api"
  plug Tesla.Middleware.JSON

  def ping() do
    case get("/ping") do
    {:ok, %{body: body}} -> body
      {_, %{body: body}} -> ""
    end
  end
end
