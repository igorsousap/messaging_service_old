defmodule Persistence.WebhooksEndpoints do
  alias Persistence.Repo
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  def create_endpoint(params) do
    params
    |> Map.put(:uuid, Ecto.UUID.generate())
    |> build_changeset()
    |> WebhookEndpoint.changeset()
    |> Repo.insert()
  end

  def get_endpoint(params),
    do: WebhookEndpoint.query(params) |> Repo.all()

  def update_user(params) do
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
