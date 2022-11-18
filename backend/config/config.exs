# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# config :backend,
#   ecto_repos: [Backend.Repo]

config :frontend,
  backend_url: "http://localhost:4001" # System.get_env("BACKEND_URL") # "http://0.0.0.0:4001"

# Configures the endpoint
config :backend, BackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "920gf/atQL+5cpNNAhTbHR5JSLwbpNknWJk5zcddIcWOati/vp6T6VdiZLyPcPNC",
  render_errors: [view: BackendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Backend.PubSub,
  live_view: [signing_salt: "ayViUXcF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
