defmodule Persistence.WebhooksEndpoints.WebhookEndpoint do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "webhooks_endpoints" do
    field :endpoint, :string
    field :event_type, :string
    field :client, :string

    timestamps()
  end

  def changeset(endpoint \\ %__MODULE__{}, params) do
    endpoint
    |> cast(params, [:endpoint, :event_type, :client])
    |> validate_required([:endpoint, :event_type, :client])
  end
end
