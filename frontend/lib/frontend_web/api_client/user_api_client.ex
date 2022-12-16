defmodule FrontendWeb.ApiClient.UserApiClient do
  import Plug.Conn, only: [get_session: 2]

  def get_other_users(%{"current_user_id" => current_user_id}) do
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/users/" <> current_user_id <> "/others"
    {:ok, body} = response.body |> Jason.decode()
    body["data"]
  end

end
