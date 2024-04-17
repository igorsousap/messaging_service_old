defmodule ProducerMessage.Sender.SenderMessage do
  require Logger

  def send_message(data) do
    Logger.info("Starting to Produce Message")

    build_data =
      data
      |> build_message()

    case Kaffe.Producer.produce_sync("currencie_converter", [build_data]) do
      :ok ->
        Logger.info("Message was been produced to topic: currencie_converter")
        {:ok, :message_send}

      {:error, body} ->
        Logger.error("Message dosen`t produced for reason: #{body}")
        {:error, body}

      _errror ->
        Logger.error("Message dosen`t produced unknow reason")
        {:error, :unknow_reason}
    end
  end

  defp build_message(data) do
    %{
      key: "currencie_converter",
      headers: [],
      value:
        %{
          "message_id" => data.message_id,
          "event_type" => data.event_type,
          "client" => data.client,
          "currencie_from" => data.currencie_from,
          "currencie_to" => data.currencie_to,
          "value_to_convert" => data.value_to_convert,
          "value_converted" => data.value_converted
        }
        |> Jason.encode!()
    }
  end
end
