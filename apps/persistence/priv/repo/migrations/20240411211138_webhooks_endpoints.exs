defmodule Persistence.Repo.Migrations.WebhooksEndpoints do
  use Ecto.Migration

  def change do
    create table(:webhooks_endpoints, primary_key: false) do
      add(:id, :uuid, primarykey: true)
      add(:endpoint, :string)
      add(:event_type, :string)
      add(:client, :string)

      timestamps()
    end

    create(unique_index(:webhooks_endpoints, [:endpoint]))
  end
end
