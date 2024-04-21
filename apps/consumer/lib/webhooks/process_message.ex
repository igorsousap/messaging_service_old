defmodule Webhooks.ProcessMessage do
  alias Schema.Webhook

  @spec message(List.t()) :: [Oban.Job.t()] | Ecto.Multi.t()
  def message(messages) do
    IO.inspect(messages, label: :messages)

    messages
    |> Enum.map(fn messages -> build_message(messages.data) end)
    |> Enum.map(&Webhook.changeset(&1))
    |> IO.inspect(label: :changeset)
    |> Enum.map(&maybe_schedule?(&1))
    |> Oban.insert_all()
  end

  defp maybe_schedule?(%Schema.Webhook{schedule_at: nil} = message),
    do: Webhooks.WorkerMessage.new(message)

  defp maybe_schedule?(%Schema.Webhook{schedule_at: schedule_at} = message),
    do: Webhooks.WorkerMessage.new(message, scheduled_at: schedule_at)

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
