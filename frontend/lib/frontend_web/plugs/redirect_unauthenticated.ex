defmodule FrontendWeb.Plugs.RedirectUnauthenticated do
  alias Phoenix.Controller
  alias Plug.Conn
  alias FrontendWeb.Router.Helpers, as: Routes

  def require_authenticated_user(conn, _opts) do
    username = Conn.get_session(conn, :username)
    if is_nil(username) do
      conn
      |> Controller.redirect(to: Routes.session_path(conn, :new))
    else
      conn
    end
  end

end