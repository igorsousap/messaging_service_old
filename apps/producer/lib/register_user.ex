defmodule RegisterUser do
  require Logger

  alias Persistence.WebhooksEndpoints

  def register_user(params) do
    case WebhooksEndpoints.create_endpoint(params) do
      {:error, _reason} ->
        Logger.error("Endpoint not register")
        {:error, :not_register}

      {:ok, _} ->
        Logger.info("Endpoint success register")
        {:ok, :success}
    end
  end

  def update_client(params) do
    case WebhooksEndpoints.update_endpoint(params) do
      {:error, _reason} ->
        Logger.error("Endpoint not updated")
        {:ok, :not_found}

      {:ok, _} ->
        Logger.info("Endpoint success update")
        {:ok, :update_success}
    end
  end

  def get_client(params) do
    case WebhooksEndpoints.get_client(params) do
      [] ->
        Logger.error("Endpoint not find")
        {:error, :not_find}

      params ->
        params
    end
  end
end
