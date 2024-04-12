defmodule Persistence.WebhooksEndpoints.WebhookEndpoint do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "webhooks_endpoints" do
    field :endpoint, :string
    field :event_type, :string
    field :client, :string
    field :schedule_at, :utc_datetime, default: nil

    timestamps()
  end

  def changeset(endpoint \\ %__MODULE__{}, params) do
    endpoint
    |> cast(params, [:endpoint, :event_type, :client, :schedule_at])
    |> validate_required([:endpoint, :event_type, :client])
  end

  def query(endpoint) do
    query =
      from w in __MODULE__,
        where: w.endpoint == ^endpoint

    IO.inspect(query)
  end
end
