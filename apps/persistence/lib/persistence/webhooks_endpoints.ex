defmodule Persistence.WebhooksEndpoints do
  alias Persistence.Repo
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  def create_endpoint(params) do
    params
    |> Map.put(:uuid, Ecto.UUID.generate())
    |> WebhookEndpoint.changeset()
    |> Repo.insert()
  end

  def get_endpoint(params), do: WebhookEndpoint.query(params) |> Repo.all() |> List.first()

  def update_endpoint(params, attrs) do
    WebhookEndpoint.query(params)
    |> Repo.all()
    |> List.first()
    |> WebhookEndpoint.changeset(attrs)
    |> Repo.update()
  end
end
