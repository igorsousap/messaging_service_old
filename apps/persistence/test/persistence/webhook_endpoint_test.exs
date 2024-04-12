defmodule Persistence.WebhookEndpointTest do
  alias Persistence.WebhooksEndpoints
  use Persistence.DataCase

  alias Persistence.WebhookEndpoint
  alias Persistence.WebhooksEndpoints.WebhookEndpoint

  describe "create_endpoint/1" do
    test "should create a user when passed valids params" do
      assert {:ok, %WebhookEndpoint{}} =
               WebhooksEndpoints.create_endpoint(%{
                 endpoint: "www.teste.com",
                 event_type: "now",
                 client: "teste"
               })
    end

    test "should get invalid message quand passed same endpoint" do
      WebhooksEndpoints.create_endpoint(%{
        endpoint: "www.teste.com",
        event_type: "now",
        client: "teste"
      })

      assert {:error, %Ecto.Changeset{}} ==
               WebhooksEndpoints.create_endpoint(%{
                 endpoint: "www.teste.com",
                 event_type: "now",
                 client: "teste"
               })
    end
  end

  describe "get_endpoint/1" do
    test "should get a endpoint" do
      WebhooksEndpoints.create_endpoint(%{
        endpoint: "www.teste.com",
        event_type: "now",
        client: "teste"
      })

      assert {:ok, %WebhookEndpoint{}} = WebhooksEndpoints.get_endpoint("www.teste.com")
    end
  end

  describe "update_endpoint/1" do
    test "should update a endpoint" do
      WebhooksEndpoints.create_endpoint(%{
        endpoint: "www.teste.com",
        event_type: "now",
        client: "teste"
      })

      assert {:ok, %WebhookEndpoint{}} =
               WebhooksEndpoints.update_endpoint("www.teste.com", %{client: "test2"})
    end
  end
end
