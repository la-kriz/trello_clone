defmodule BackendWeb.PermissionController do
  use BackendWeb, :controller

  alias Backend.Accounts.User
  alias Backend.Access

  action_fallback BackendWeb.FallbackController

  def share_to_users(conn, %{"users" => users, "board_id" => board_id}) do
    for {k, v} <- users do
      user_id = v["user_id"]
      user_permission = String.to_atom v["user_permission"]
      Access.set_permission_by_user_id(user_id, user_permission, board_id)
    end
    conn
    |> put_status(:ok)
  end

  def get_permission_by_user_and_board(conn, %{"user_id" => user_id, "board_id" => board_id}) do
    {:ok, permission} = Access.get_permission_by_user_and_board(user_id, board_id)

    render(conn, "show.json", permission: permission)
  end

end
