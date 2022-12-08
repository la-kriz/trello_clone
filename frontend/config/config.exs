# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# config :backend,
#   frontend_url: "http://0.0.0.0:4000"

# config :frontend,
#   ecto_repos: [Frontend.Repo]

# Configures the endpoint
config :frontend, FrontendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fed1VSpQEsOnoImeuYcFL1ew2QaChbzmqP1SRpYsk4W829Ty6RaC2f6h0nOtSSzD",
  render_errors: [view: FrontendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Frontend.PubSub,
  live_view: [signing_salt: "XU/UxE0D"]

config :backend, Frontend.Guardian,
       issuer: "backend",
       secret_key: "lXnlcYpB3NJKOdu/9A1sojKF3EhoK4fJySijh5Rkyq9Au13L42hP5xWQtYISUzAv"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
