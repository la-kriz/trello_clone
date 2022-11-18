defmodule FrontendWeb.PingController do
  use FrontendWeb, :controller

  alias Frontend.API

  def show(conn, _params) do

    # text(conn, API.ping())
    # text(conn, HTTPoison.get "http://0.0.0.0:4001/api/ping")
    # HTTPoison.get "http://0.0.0.0:4001/api/ping"
    # {:ok, response} = HTTPoison.get "http://0.0.0.0:4000/hello"
    {:ok, response} = HTTPoison.get "http://host.docker.internal:4001/api/ping"
    text(conn, response.body)
  end

  def hello(conn, _params) do

    text(conn, "Hello World")
  end
end
