defmodule FrontendWeb.SessionController do
  use FrontendWeb, :controller

  alias Frontend.Api.Accounts
  alias Frontend.Api.Accounts.User
  alias Frontend.Guardian, as: TokenImpl

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def register(conn, %{"user" => user_params}) do
    body = Jason.encode! %{"user" => user_params}

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/users/register",
                                     body, [{"Content-Type", "application/json"}]

    redirect(conn, to: Routes.task_path(conn, :index))
  end

  def get_login(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "login.html", changeset: changeset)
  end

  def login(conn, %{"user" => user_params}) do
    body = Jason.encode! %{"email" => user_params["email"], "password" => user_params["password"]}

    {:ok, response} = HTTPoison.post "http://host.docker.internal:4001/api/session/new",
                                     body, [{"Content-Type", "application/json"}]

    {:ok, body} = response.body |> Jason.decode()

    access_token = body["access_token"]
    assign(conn, :access_token, access_token)

    {:ok, payload} = TokenImpl.decode_and_verify(access_token)
    username = payload["username"]
    IO.inspect(username, label: ">>>>>> payload username is ")

    conn = put_session(conn, :username, username)

    redirect(conn, to: Routes.task_path(conn, :index))
  end

end