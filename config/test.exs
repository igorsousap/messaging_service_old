import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :producer, Producer.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RBAybaYqoRRvsU7/uZIVcsrEqdZnwLsvI4DocnLq4MLhl85ZzDMo78x1W6udfVGk",
  server: false
