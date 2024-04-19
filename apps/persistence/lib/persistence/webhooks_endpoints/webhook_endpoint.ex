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
