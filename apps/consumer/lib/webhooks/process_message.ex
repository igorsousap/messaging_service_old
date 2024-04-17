defmodule Webhooks.ProcessMessage do
  def message(messages) do
    messages
    |> Enum.map(fn messages -> build_message(messages.data) end)
    |> Enum.map(fn message -> Webhooks.WorkerMessage.new(message) end)
    |> IO.inspect(label: :new_oban)
    |> Oban.insert_all()
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
      value_to_convert: data["value_to_convert"]
    }
  end
end
