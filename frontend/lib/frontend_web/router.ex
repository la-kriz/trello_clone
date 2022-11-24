defmodule FrontendWeb.Router do
  use FrontendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FrontendWeb do
    pipe_through :browser

    get "/lists", ListController, :index
    get "/lists/new", ListController, :new
    delete "/lists/:list_id/", ListController, :delete
    get "/", TaskController, :index
    get "/tasks/new", TaskController, :new
    post "/tasks", TaskController, :create
    get "/tasks/:id", TaskController, :show
    get "/tasks/:id/edit", TaskController, :edit
    post "/tasks/:id", TaskController, :update
    get "/tasks/:id/delete", TaskController, :delete
    get("/ping", PingController, :show)
    get("/hello", PingController, :hello)
  end

  # Other scopes may use custom stacks.
  # scope "/api", FrontendWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FrontendWeb.Telemetry


    end
  end
end
