defmodule Consumer.ConsumerMessage do
  use Broadway

  alias Broadway.Message
  alias Persistence.WebhooksEndpoints
  alias Webhooks.ProcessMessage

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "group_1",
             topics: ["currencie_converter"]
           ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 200,
          concurrency: 10
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    with message <- Message.update_data(message, fn data -> Jason.decode!(data) end),
         endpoint <-
           WebhooksEndpoints.get_endpoint(%{
             "event_type" => message.data["event_type"],
             "client" => message.data["client"]
           }),
         message_update <-
           update_message_endpoint(message, endpoint) do
      message_update
    end
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    ProcessMessage.message(messages)
    messages
  end

  defp update_message_endpoint(message, endpoint) do
    [endpoint | _] = endpoint

    endpoint = Map.fetch!(endpoint, :endpoint)

    message_update =
      message
      |> Message.update_data(fn data -> Map.put(data, "endpoint", endpoint) end)

    message_update
  end
end
