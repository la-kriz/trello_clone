defmodule BackendWeb.SessionController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Guardian
  alias Backend.Access

  action_fallback BackendWeb.FallbackController

  def new(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->

        {:ok, permission} = case Access.get_permission_by_user(user.id) do
          {:ok, perm} -> {:ok, perm}
          {:error, :not_found} -> {:ok, %{permission: nil}}
        end

        {:ok, access_token, _claims} =
          Guardian.encode_and_sign(user, %{user_id: user.id, username: user.username, permission: permission.permission},
            token_type: "access", ttl: {30, :day})

        {:ok, refresh_token, _claims} =
          Guardian.encode_and_sign(user, %{user_id: user.id, username: user.username, permission: permission.permission},
            token_type: "refresh", ttl: {7, :day})

        conn
        |> put_resp_cookie("ruid", refresh_token)
        |> put_status(:created)
        |> render("token.json", access_token: access_token)

      {:error, :unauthorized} ->
        body = Jason.encode!(%{error: "unauthorized"})

        conn
        |> send_resp(401, body)
    end
  end

  def refresh(conn, _params) do
    refresh_token =
      Plug.Conn.fetch_cookies(conn)
      |> Map.from_struct()
      |> get_in([:cookies, "ruid"])

    case Guardian.exchange(refresh_token, "refresh", "access") do
      {:ok, _old_stuff, {new_access_token, _new_claims}} ->
        conn
        |> put_status(:created)
        |> render("token.json", %{access_token: new_access_token})

      {:error, _reason} ->
        body = Jason.encode!(%{error: "unauthorized"})

        conn
        |> send_resp(401, body)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_resp_cookie("ruid")
    |> put_status(200)
    |> text("Log out successful.")
  end
end
