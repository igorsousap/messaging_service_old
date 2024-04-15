defmodule Persistence.WebhooksEndpoints.WebhookEndpoint do
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

  def changeset(endpoint \\ %__MODULE__{}, params) do
    endpoint
    |> cast(params, [:endpoint, :event_type, :client])
    |> unique_constraint([:endpoint])
    |> validate_required([:endpoint, :event_type, :client])
  end

  def query(params) do
    case params do
      %{"endpoint" => endpoint} ->
        query =
          from(w in __MODULE__,
            where: w.endpoint == ^endpoint
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
