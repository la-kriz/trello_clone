defmodule FrontendWeb.ApiClient.SessionApiClient do
  import Plug.Conn, only: [get_session: 2]

  def register(conn, %{"user" => user_params}) do

    body = Jason.encode! %{"user" => user_params}

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/users/register",
                                      body, [{"Content-Type", "application/json"}]
  end

end
