# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :socialize,
  ecto_repos: [Socialize.Repo]

# Configures the endpoint
config :socialize, SocializeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vmRcGD+j8Tl9woK7hL6+a0OjPnyMv3JW8xUoiAXjIsEGKG9Emn6AYBxa8a9ujgLp",
  render_errors: [view: SocializeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Socialize.PubSub,
  live_view: [signing_salt: "zp/KgnGA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
