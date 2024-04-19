defmodule Webhooks.ClientMessage do
  use Tesla

  plug(Tesla.Middleware.JSON)

  def send_webhook(data, endpoint) do
    post(endpoint <> "/", data)
  end
end
