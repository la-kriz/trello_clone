defmodule FrontendWeb.Plugs.RedirectNoBoardAccess do
  alias Phoenix.Controller
  alias Plug.Conn
  alias FrontendWeb.Router.Helpers, as: Routes

  def require_user_has_access_to_board(conn, _opts) do
    permission = Conn.get_session(conn, :permission)
    if is_nil(permission) do
      conn
      |> Controller.redirect(to: Routes.board_path(conn, :index))
    else
      conn
    end

  end

end