defmodule Persistence.WebhooksEndpointsTest do
  use Persistence.DataCase

  alias Persistence.WebhooksEndpoints
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  describe "create_endpoint/1" do
    test "should create a user when passed valids params" do
      assert {:ok, %WebhookEndpoint{}} =
               WebhooksEndpoints.create_endpoint(%{
                 "client" => "teste",
                 "event_type" => "send.message.converter",
                 "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
               })
    end

    test "should get invalid message quand passed same endpoint" do
      WebhooksEndpoints.create_endpoint(%{
        "client" => "teste",
        "event_type" => "send.message.converter",
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
      })

      assert {:error,
              %Ecto.Changeset{
                action: :insert,
                changes: %{
                  client: "teste",
                  endpoint: "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c",
                  event_type: "send.message.converter"
                },
                errors: [
                  endpoint:
                    {"has already been taken",
                     [constraint: :unique, constraint_name: "webhooks_endpoints_endpoint_index"]}
                ]
              }} =
               WebhooksEndpoints.create_endpoint(%{
                 "client" => "teste",
                 "event_type" => "send.message.converter",
                 "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
               })
    end
  end

  describe "get_endpoint/1" do
    test "should get a endpoint" do
      WebhooksEndpoints.create_endpoint(%{
        "client" => "teste",
        "event_type" => "send.message.converter",
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
      })

      assert [%Persistence.WebhooksEndpoints.WebhookEndpoint{}] =
               WebhooksEndpoints.get_endpoint(%{
                 "client" => "teste",
                 "event_type" => "send.message.converter"
               })
    end
  end

  describe "update_endpoint/1" do
    test "should update a endpoint" do
      WebhooksEndpoints.create_endpoint(%{
        "client" => "teste",
        "event_type" => "send.message.converter",
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
      })

      assert {:ok, %WebhookEndpoint{}} =
               WebhooksEndpoints.update_endpoint(%{
                 "client" => "teste",
                 "event_type" => "send.message.converter",
                 "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
               })
    end
  end
end
