defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Accounts.User

  action_fallback BackendWeb.FallbackController

  def register(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> text("User successfully registered with email: " <> " " <> user.email)
    end
  end

  def get_other_users(conn, %{"id" => id}) do
    users = Accounts.get_other_users(id)
    render(conn, "user_list_for_sharing.json", users: users)
  end

end
