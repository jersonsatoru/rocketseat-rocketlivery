# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rocketlivery,
  ecto_repos: [Rocketlivery.Repo],
  generators: [binary_id: true]

config :rocketlivery, Rocketlivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :rocketlivery, RocketliveryWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: RocketliveryWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Rocketlivery.PubSub,
  live_view: [signing_salt: "NzL0FcRK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :rocketlivery,
  zipcode_gateway: System.get_env("ZIPCODE_GATEWAY")

config :rocketlivery,
  Rocketlivery.Users.Create,
  zipcode_gateway_adapter: ZipcodeGateway.Client

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
