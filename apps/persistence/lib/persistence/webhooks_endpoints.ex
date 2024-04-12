defmodule Persistence.WebhooksEndpoints do
  alias Persistence.Repo
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  def create_endpoint(params) do
    params
    |> Map.put(:uuid, Ecto.UUID.generate())
    |> WebhookEndpoint.changeset()
    |> Repo.insert()
  end

  def get_endpoint(endpoint), do: WebhookEndpoint.query(endpoint) |> Repo.all() |> List.first()

  def update_endpoint(endpoint, attrs) do
    WebhookEndpoint.query(endpoint)
    |> Repo.all()
    |> List.first()
    |> WebhookEndpoint.changeset(attrs)
    |> Repo.update()
  end
end
