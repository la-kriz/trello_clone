defmodule BackendWeb.PermissionController do
  use BackendWeb, :controller

  alias Backend.Accounts.User
  alias Backend.Access

  action_fallback BackendWeb.FallbackController

  def share_to_users(conn, %{"users" => users}) do
    for {k, v} <- users do
      user_id = v["user_id"]
      user_permission = String.to_atom v["user_permission"]
      Access.set_permission_by_user_id(user_id, user_permission)
    end
    conn
    |> put_status(:ok)
  end

end
