defmodule Persistence.WebhooksEndpoints do
  alias Persistence.Repo
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  def create_endpoint(params) do
    params
    |> Map.put(:uuid, Ecto.UUID.generate())
    |> WebhookEndpoint.changeset()
    |> Repo.insert()
  end

  def get_endpoint(endpoint), do: Repo.get!(WebhookEndpoint, endpoint)

  def update_endpoint(params, attrs) do
    params
    |> WebhookEndpoint.changeset(attrs)
    |> Repo.update()
  end
end
