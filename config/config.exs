# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :persistence,
  ecto_repos: [Persistence.Repo]

# Configures the endpoint
config :producer, Producer.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: Producer.ErrorJSON],
    layout: false
  ],
  pubsub_server: Producer.PubSub,
  live_view: [signing_salt: "VCY3c1oQ"]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
config :phoenix, :json_library, Jason

config :kaffe,
  producer: [
    endpoints: [localhost: 9092],
    topics: ["currencie_converter"]
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Oban Config
config :consumer, Oban,
  engine: Oban.Engines.Lite,
  queues: [default: 10],
  repo: Persistence.Repo,
  plugins: [Oban.Plugins.Pruner]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
