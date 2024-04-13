defmodule RegisterClient do
  require Logger

  alias Persistence.WebhooksEndpoints

  def register_client(params) do
    case WebhooksEndpoints.create_endpoint(params) do
      {:error, reason} ->
        Logger.error("Endpoint not register for reason: #{reason}")

      {:ok, _} ->
        Logger.info("Endpoint success register")
        {:ok, :success}
    end
  end

  def update_client(params, attrs) do
    case WebhooksEndpoints.update_endpoint(params, attrs) do
      {:error, reason} ->
        Logger.error("Endpoint not update reason: #{reason}")

      {:ok, _} ->
        Logger.info("Endpoint success update")
        {:ok, :update_success}
    end
  end

  def get_client(params) do
    case WebhooksEndpoints.get_endpoint(params) do
      {:error, reason} ->
        Logger.error("Endpoint not find reason: #{reason}")

      {:ok, response} ->
        response
    end
  end
end
