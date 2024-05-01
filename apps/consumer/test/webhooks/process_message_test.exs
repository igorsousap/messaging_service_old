defmodule Webhooks.ProcessMessageTest do
  use ExUnit.Case

  alias Webhooks.ProcessMessage

  @message %Broadway.Message{
    data: %{
      "client" => "teste",
      "currencie_from" => "USD",
      "currencie_to" => "BRL",
      "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/",
      "event_type" => "sender.message_converter",
      "message_id" => "9f2cab28-24f1-4a9d-be40-d1a63411ce7b",
      "schedule_at" => nil,
      "value_converted" => "255.76500000000001",
      "value_to_convert" => "50"
    },
    metadata: %{
      headers: [],
      key: "currencie_converter",
      offset: 11,
      partition: 0,
      topic: "currencie_converter",
      ts: 1_714_486_205_032
    },
    acknowledger: {BroadwayKafka.Acknowledger},
    batcher: :default,
    batch_key: {"currencie_converter", 0},
    batch_mode: :bulk,
    status: :ok
  }

  @message_schedule %Broadway.Message{
    data: %{
      "client" => "teste",
      "currencie_from" => "USD",
      "currencie_to" => "BRL",
      "endpoint" => "https://webhook.site/68d090b2-e5ad-40d3-a990-b3dc45dcf17c/",
      "event_type" => "sender.message_converter",
      "message_id" => "9f2cab28-24f1-4a9d-be40-d1a63411ce7b",
      "schedule_at" => "2000-01-01 00:00:00",
      "value_converted" => "255.76500000000001",
      "value_to_convert" => "50"
    },
    metadata: %{
      headers: [],
      key: "currencie_converter",
      offset: 11,
      partition: 0,
      topic: "currencie_converter",
      ts: 1_714_486_205_032
    },
    acknowledger: {BroadwayKafka.Acknowledger},
    batcher: :default,
    batch_key: {"currencie_converter", 0},
    batch_mode: :bulk,
    status: :ok
  }

  describe "message/1" do
    test "Should return a list of oban jobs when given valid messages from broadway messages" do
      message = [
        @message,
        @message
      ]

      assert [%Oban.Job{}, %Oban.Job{}] = ProcessMessage.message(message)
    end

    test "Should return a list of oban jobs scheduled when given valid messages from broadway message" do
      message = [
        @message_schedule,
        @message_schedule
      ]

      assert [%Oban.Job{}, %Oban.Job{}] = ProcessMessage.message(message)
    end
  end
end
