defmodule Webhooks.ClientMessage do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c")
  plug(Tesla.Middleware.JSON)

  def send_webhook(data) do
    post("/", data)
  end
end
