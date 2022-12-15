defmodule FrontendWeb.SessionController do
  use FrontendWeb, :controller

  alias Frontend.Api.Accounts
  alias Frontend.Api.Accounts.User
  alias Frontend.Guardian, as: TokenImpl

  alias FrontendWeb.ApiClient.SessionApiClient

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def register(conn, %{"user" => user_params}) do

    SessionApiClient.register(conn, %{"user" => user_params})

    redirect(conn, to: Routes.session_path(conn, :get_login))
  end

  def get_login(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "login.html", changeset: changeset)
  end

  def login(conn, %{"user" => user_params}) do

    access_token = SessionApiClient.login(conn, %{"email" => user_params["email"], "password" => user_params["password"]})

    {:ok, payload} = TokenImpl.decode_and_verify(access_token)
    user_id = payload["user_id"]
    username = payload["username"]
    permission = payload["permission"]

    conn = put_session(conn, :user_id, user_id)
    conn = put_session(conn, :username, username)
    conn = put_session(conn, :access_token, access_token)
    conn = put_session(conn, :permission, permission)

    redirect(conn, to: Routes.board_path(conn, :index))
  end

  def logout(conn, _params) do

    SessionApiClient.logout(conn)

    conn = delete_session(conn, :user_id)
    conn = delete_session(conn, :username)
    conn = delete_session(conn, :access_token)
    conn = delete_session(conn, :permission)

    redirect(conn, to: Routes.session_path(conn, :new))
  end
end