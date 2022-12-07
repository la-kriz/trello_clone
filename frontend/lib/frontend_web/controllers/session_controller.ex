defmodule FrontendWeb.SessionController do
  use FrontendWeb, :controller

  alias Frontend.Api.Accounts
  alias Frontend.Api.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def register(conn, %{"user" => user_params}) do
    body = Jason.encode! %{"user" => user_params}

    {:ok, _response} = HTTPoison.post "http://host.docker.internal:4001/api/users",
                                     body, [{"Content-Type", "application/json"}]

    redirect(conn, to: Routes.task_path(conn, :index))
  end

end