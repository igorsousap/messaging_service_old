defmodule Webhooks.ClientMessage do
  use Tesla

  plug(Tesla.Middleware.JSON)

  @spec send_webhook(map(), binary()) :: {:error, any()} | {:ok, Tesla.Env.t()}
  def send_webhook(data, endpoint) do
    post(endpoint <> "/", data)
  end
end
