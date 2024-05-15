import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :producer, Producer.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RBAybaYqoRRvsU7/uZIVcsrEqdZnwLsvI4DocnLq4MLhl85ZzDMo78x1W6udfVGk",
  server: false

config :persistence, Persistence.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  database: "persistence_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 100

config :tesla, adapter: Tesla.Mock

config :consumer,
  consumer_module: Broadway.DummyProducer
