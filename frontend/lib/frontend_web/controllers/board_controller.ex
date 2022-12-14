defmodule FrontendWeb.BoardController do
  use FrontendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
