defmodule FrontendWeb.ApiClient.SessionApiClient do
  import Plug.Conn, only: [get_session: 2]

  def register(conn, %{"user" => user_params}) do

    body = Jason.encode! %{"user" => user_params}

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/users/register",
                                      body, [{"Content-Type", "application/json"}]
  end

  def login(conn, %{"email" => email, "password" => password}) do

    body = Jason.encode! %{"email" => email, "password" => password}

    {:ok, response} = HTTPoison.post "http://host.docker.internal:4001/api/session/new",
                                     body, [{"Content-Type", "application/json"}]

    {:ok, body} = response.body |> Jason.decode()

    body["access_token"]
  end

  def logout(conn) do
    body = Jason.encode! %{}

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/session/delete",
                                     body, headers
  end

end
