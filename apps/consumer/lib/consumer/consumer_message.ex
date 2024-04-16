defmodule Consumer.ConsumerMessage do
  use Broadway

  alias Broadway.Message

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
    message
    |> IO.inspect(label: :message)
    |> Message.update_data(fn data -> Jason.decode!(data) end)
    |> IO.inspect(lavel: :message_updated)
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    IO.inspect(messages, label: "Got batch")
    messages
  end
end
