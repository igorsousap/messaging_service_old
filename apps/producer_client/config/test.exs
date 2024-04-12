import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :producer_client, ProducerClientWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "C4OUyhZX4E/lVrbW22FsS2K20OBPM2H3lbh1tZ2F0omyTnbaydBhUzjaYLPTvZW4",
  server: false

# In test we don't send emails.
config :producer_client, ProducerClient.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
