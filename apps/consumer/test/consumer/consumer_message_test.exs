defmodule Consumer.ConsumerMessageTest do
  use ExUnit.Case, async: true

  alias Persistence.WebhooksEndpoints

  @data %{
    "client" => "teste",
    "currencie_from" => "USD",
    "currencie_to" => "BRL",
    "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/",
    "event_type" => "sender.message_converter",
    "message_id" => "9f2cab28-24f1-4a9d-be40-d1a63411ce7b",
    "schedule_at" => nil,
    "value_converted" => "255.76500000000001",
    "value_to_convert" => "50"
  }

  describe "handle_message/3" do
    test "receive a message from kafka and send to be processed" do
      WebhooksEndpoints.create_endpoint(%{
        "client" => "teste",
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/",
        "event_type" => "sender.message_converter"
      })

      ref =
        Broadway.test_message(
          Consumer.ConsumerMessage,
          Jason.encode!(@data),
          metadata: %{
            headers: [],
            key: "currencie_converter",
            partition: 0,
            topic: "currencie_converter"
          }
        )

      assert_receive {:ack, ^ref, [%{data: @data}], []}, 5_000
    end
  end

  describe "handle_batch/3" do
    test "receive a batch message from kafka and send to be processed" do
      WebhooksEndpoints.create_endpoint(%{
        "client" => "teste",
        "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/",
        "event_type" => "sender.message_converter"
      })

      ref_batch =
        Broadway.test_batch(
          Consumer.ConsumerMessage,
          [Jason.encode!(@data), Jason.encode!(@data)],
          metadata: %{
            headers: [],
            key: "currencie_converter",
            partition: 0,
            topic: "currencie_converter"
          }
        )

      assert_receive {:ack, ^ref_batch, [%{data: @data}, %{data: @data}], []}, 5_000
    end
  end
end
