defmodule FrontendWeb.PingController do
  use FrontendWeb, :controller

  alias Frontend.API

  def show(conn, _params) do

    text(conn, API.ping())
  end
end
