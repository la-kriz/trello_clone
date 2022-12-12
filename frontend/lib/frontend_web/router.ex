defmodule FrontendWeb.Router do
  use FrontendWeb, :router

  import FrontendWeb.Plugs.RedirectUnauthenticated

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FrontendWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FrontendWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/", TaskLive

    delete "/lists/:list_id/", ListController, :delete
    get "/lists/new", ListController, :new

    get "/lists/:list_id/tasks/new", TaskController, :new
    post "/lists/:list_id/tasks", TaskController, :create
  end

  scope "/", FrontendWeb do
    pipe_through :browser

    get "/register", SessionController, :new
    post "/register", SessionController, :register

    get "/login", SessionController, :get_login
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout

    get "/lists/:list_id/tasks/:id", TaskController, :show
    get "/lists/:list_id/tasks/:id/edit", TaskController, :edit
    post "/lists/:list_id/tasks/:id", TaskController, :update
    delete "/tasks/:id/delete", TaskController, :delete

    get("/ping", PingController, :show)
    get("/hello", PingController, :hello)

    live "/lists/title", ListsTitleLive
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
