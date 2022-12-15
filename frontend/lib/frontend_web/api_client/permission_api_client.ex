defmodule FrontendWeb.ApiClient.PermissionApiClient do
  import Plug.Conn, only: [get_session: 2]

  def get_permission_of_user_on_board(conn, %{"board_id" => board_id}) do
    user_id = Integer.to_string(get_session(conn, :user_id))

    access_token = get_session(conn, :access_token)
    headers = [{:"Authorization", "Bearer #{access_token}"}, {:"Content-Type", "application/json"}]

    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/permissions/users/" <> user_id <> "/boards/" <> board_id,
                                    headers
    {:ok, permission_body} = response.body |> Jason.decode()

    permission_body["data"]
  end

end
