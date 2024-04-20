defmodule RegisterUser do
  @moduledoc """
  Module for register, update and return clients from database
  """
  require Logger

  alias Persistence.WebhooksEndpoints

  @doc """
  receive a map and insert a user on database
  ## Examples

      iex> RegisterUser.register_user(%{
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
        "event_type" => "sender.message_converter"
        "client" => "test"
      })

  """

  @spec register_user(map()) :: {:error, :not_register} | {:ok, :success}
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

  @doc """
  update a user on database
  ## Examples
    If you want to update a endpoint, gives the client and event_type and new endpoint
      iex> RegisterUser.update_client(%{
        "event_type" => "sender.message_converter"
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
        "client" => "test"
      })

  """

  @spec update_client(map()) :: {:ok, :not_found | :update_success}
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

  @doc """
  get all endpoints and events on database from given client
  ## Examples
    If you want to update a endpoint, gives the client and event_type and new endpoint
      iex> RegisterUser.get_client(%{
        "client" => "test"
      })

  """

  @spec get_client(map()) :: any()
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
