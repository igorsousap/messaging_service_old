defmodule Persistence.WebhooksEndpoints.WebhookEndpointTest do
  use ExUnit.Case
  alias Persistence.WebhooksEndpoints.WebhookEndpoint
  alias Persistence.WebhooksEndpoints

  describe "changeset/2" do
    test "should retunr a valid changeset when given valid params" do
      assert %Ecto.Changeset{
               changes: %{
                 client: "teste",
                 endpoint: "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c",
                 event_type: "send.message.converter"
               }
             } =
               WebhookEndpoint.changeset(%{
                 "client" => "teste",
                 "event_type" => "send.message.converter",
                 "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
               })
    end

    test "should retunr a updated changeset when given valid params" do
      assert %Ecto.Changeset{
               changes: %{
                 endpoint: "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
               }
             } =
               WebhookEndpoint.changeset(
                 %Persistence.WebhooksEndpoints.WebhookEndpoint{
                   client: "teste",
                   event_type: "send.message.converter",
                   endpoint: "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c"
                 },
                 %{
                   "client" => "teste",
                   "event_type" => "send.message.converter",
                   "endpoint" =>
                     "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/updated"
                 }
               )
    end
  end

  describe "query/1" do
    test "should return a query when given valid params" do
      assert %Ecto.Query{} = WebhookEndpoint.query(%{"client" => "teste"})
    end
  end
end
