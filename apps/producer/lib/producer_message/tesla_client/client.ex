defmodule ProducerMessage.TeslaClient.Client do
  use Tesla
  require Logger

  @token_key "f27c129f6b12d65ab29c0652"

  plug Tesla.Middleware.BaseUrl, "https://v6.exchangerate-api.com/v6"
  plug Tesla.Middleware.Headers, [{"authorization", @token_key}]
  plug Tesla.Middleware.JSON

  def currencie(currencie) do
    case get("/#{@token_key}/latest/#{currencie}") do
      {:ok, %Tesla.Env{status: 404}} ->
        {:error, :unsuported_code}

      {:ok, %Tesla.Env{} = response} ->
        Logger.info("Valid Request on client http")

        {:ok, response.body}
    end
  end
end
