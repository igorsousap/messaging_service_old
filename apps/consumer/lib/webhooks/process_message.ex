defmodule Webhooks.ProcessMessage do
  require Logger
  alias Schema.Webhook

  @doc """
  Receive a list of messages from consumer module and process so be sndo to oban

  ## Examples

      iex> Webhooks.ProcessMessage,message([%Broadway.Message{
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
  }])

  """

  @spec message(List.t()) :: [Oban.Job.t()] | Ecto.Multi.t()
  def message(messages) do
    messages
    |> Enum.map(fn messages -> build_message(messages.data) end)
    |> Enum.map(&Webhook.changeset(&1))
    |> Enum.map(&maybe_schedule?(&1))
    |> Oban.insert_all()
  end

  defp maybe_schedule?(%Schema.Webhook{schedule_at: nil} = message),
    do: Webhooks.WorkerMessage.new(message)

  defp maybe_schedule?(%Schema.Webhook{schedule_at: schedule_at} = message) do
    Logger.info("Messagging was been scheduled")
    Webhooks.WorkerMessage.new(message, scheduled_at: schedule_at)
  end

  defp build_message(data) do
    %{
      client: data["client"],
      currencie_from: data["currencie_from"],
      currencie_to: data["currencie_to"],
      endpoint: data["endpoint"],
      event_type: data["event_type"],
      message_id: data["message_id"],
      value_converted: data["value_converted"],
      value_to_convert: data["value_to_convert"],
      schedule_at: data["schedule_at"]
    }
  end
end
