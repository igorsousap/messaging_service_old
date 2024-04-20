defmodule Persistence.WebhooksEndpoints do
  @moduledoc """
  CRUD for register client on database
  """
  alias Persistence.Repo
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  @doc """
  Receive a map to be inserted on database
  ## Examples

      iex> Persistence.WebhooksEndpoints.create_endpoint(%{
          "client" => "teste",
          "event_type" => "send.message.converter",
          "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
        })

  """

  @spec create_endpoint(%{
          :client => String.t(),
          :event_type => String.t(),
          :endpoint => String.t()
        }) :: {:ok, %Persistence.WebhooksEndpoints.WebhookEndpoint{}}
  def create_endpoint(params) do
    params
    |> Map.put(:uuid, Ecto.UUID.generate())
    |> build_changeset()
    |> WebhookEndpoint.changeset()
    |> Repo.insert()
  end

  @doc """
  Receive a client and return a lis of endpoints and events register for the client
  ## Examples

      iex> Persistence.WebhooksEndpoints.get_client(%{
          "client" => "teste"
        })

  """

  @spec get_client(%{:client => String.t()}) ::
          [Ecto.Schema.t()] | []
  def get_client(params),
    do: WebhookEndpoint.query(params) |> Repo.all()

  @doc """
  Receive a client and event_type and return a lis of endpoints and events register for the client
  ## Examples

      iex> Persistence.WebhooksEndpoints.get_endpoint(%{
          "client" => "teste",
          "event_type" => "send.message.converter"
        })

  """
  @spec get_endpoint(%{:client => String.t(), :event_type => String.t()}) ::
          Ecto.Schema.t() | []
  def get_endpoint(params),
    do: WebhookEndpoint.query(params) |> Repo.all()

  @doc """
  Receive a client and event to be updated a endpoint on database
  ## Examples

      iex> Persistence.WebhooksEndpoints.update_endpoint(%{
          "client" => "teste",
          "event_type" => "send.message.converter",
          "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
        })

  """

  @spec update_endpoint(%{:client => String.t(), :event_type => String.t()}) ::
          {:ok, %Persistence.WebhooksEndpoints.WebhookEndpoint{}} | {:error, :not_found}
  def update_endpoint(params) do
    query = WebhookEndpoint.query(params)

    case Repo.all(query) do
      [] ->
        {:error, :not_found}

      result ->
        result
        |> List.first()
        |> WebhookEndpoint.changeset(params)
        |> Repo.update()
    end
  end

  defp build_changeset(data) do
    %{
      id: data["uuid"],
      client: data["client"],
      endpoint: data["endpoint"],
      event_type: data["event_type"]
    }
  end
end
