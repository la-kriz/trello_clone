defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json","html"]
  end

  pipeline :auth do
    plug Backend.Guardian.AuthPipeline
  end

  scope "/", BackendWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", BackendWeb do
    pipe_through :api

    post "/users/register", UserController, :register
    get "/users/:id/others", UserController, :get_other_users

    post "/permissions/share", PermissionController, :share_to_users

    post "/session/new", SessionController, :new

  end

  scope "/api", BackendWeb do
    pipe_through [:api, :auth]

    get "/boards/users/:user_id", BoardController, :index
    post "/boards/create", BoardController, :create

    get "/permissions/users/:user_id/boards/:board_id", PermissionController, :get_permission_by_user_and_board

    get "/boards/:board_id/lists", ListController, :index

    resources "/lists", ListController, except: [:edit, :index] do
      resources "/tasks", TaskController, except: [:new, :edit, :delete]
    end

    resources "/comments", CommentController, except: [:new, :edit]

    delete "/tasks/:id", TaskController, :delete

    post "/session/refresh", SessionController, :refresh
    post "/session/delete", SessionController, :delete

  end
  # Other scopes may use custom stacks.
  # scope "/api", BackendWeb do
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
      live_dashboard "/dashboard", metrics: BackendWeb.Telemetry
    end
  end
end
