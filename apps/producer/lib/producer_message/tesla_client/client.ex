defmodule ProducerMessage.TeslaClient.Client do
  @moduledoc """
  The client of get the table of convertion currencies for the currencie given.
  """
  use Tesla
  require Logger

  @token_key "f27c129f6b12d65ab29c0652"

  plug Tesla.Middleware.BaseUrl, "https://v6.exchangerate-api.com/v6"
  plug Tesla.Middleware.Headers, [{"authorization", @token_key}]
  plug Tesla.Middleware.JSON

  @doc """
  Request the currencie to be converted and retunr the values for the other currencies
  Obs.: The token key needs to be changed for you token key where you can get from:
  https://www.exchangerate-api.com/
  ## Examples

      iex> ProducerMessage.TeslaClient.Client.currencie("USD")

  """

  @spec currencie(Integer.t()) :: {:error, :unsuported_code} | {:ok, any()}
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
