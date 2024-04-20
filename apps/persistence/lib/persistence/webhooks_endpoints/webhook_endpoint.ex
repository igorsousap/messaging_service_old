defmodule Persistence.WebhooksEndpoints.WebhookEndpoint do
  @moduledoc """
  Ecto changeset for validation the struct to be sabed and query for get and update
  """
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "webhooks_endpoints" do
    field(:endpoint, :string)
    field(:event_type, :string)
    field(:client, :string)

    timestamps()
  end

  @doc """
  Can receive a struct for update a data or nothing and return a empyt struct to be created on database
  ## Examples
    case for a update a existing data
      iex> Persistence.WebhooksEndpoints.WebhookEndpoint(
        %Persistence.WebhooksEndpoints.WebhookEndpoint{
          "client" => "teste",
          "event_type" => "send.message.converter",
          "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
        },
        %{
          "client" => "teste",
          "event_type" => "send.message.converter",
          "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
        })
  Case for a insert a new data
      iex> Persistence.WebhooksEndpoints.WebhookEndpoint(
        %{
          "client" => "teste",
          "event_type" => "send.message.converter",
          "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
        })

  """

  @spec changeset(%Persistence.WebhooksEndpoints.WebhookEndpoint{
          id: String.t(),
          client: String.t(),
          endpoint: String.t(),
          event_type: String.t()
        }) :: Ecto.Changeset.t()
  @spec changeset(%{optional(:__struct__) => none(), optional(atom() | binary()) => any()}) ::
          Ecto.Changeset.t()
  def changeset(endpoint \\ %__MODULE__{}, params) do
    endpoint
    |> cast(params, [:endpoint, :event_type, :client])
    |> unique_constraint([:endpoint])
    |> validate_required([:endpoint, :event_type, :client])
  end

  @doc """
  Receive a map fo make a query to a Repo functions
  ## Examples
    case for a update a existing data
      iex> Persistence.WebhooksEndpoints.WebhookEndpoint.query(%{client => "teste"})

  """
  @spec query(map()) :: Ecto.Query.t()
  def query(params) do
    case params do
      %{"client" => client, "event_type" => event_type} ->
        query =
          from(w in __MODULE__,
            where:
              w.client == ^client and
                w.event_type == ^event_type
          )

        query

      %{"id" => id} ->
        query =
          from(w in __MODULE__,
            where: w.id == ^id
          )

        query

      %{"client" => client} ->
        query =
          from(w in __MODULE__,
            where: w.client == ^client
          )

        query
    end
  end
end
