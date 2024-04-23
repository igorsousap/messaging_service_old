defmodule ProducerMessage.Sender.SenderMessage do
  @moduledoc """
  The Sender Message Kafka Context.
  """
  require Logger

  @doc """
  Send a message with the data to kafka

  ## Examples

      iex> ProducerMessage.Sender.SenderMessage.send_message %{
          message_id: Ecto.UUID.generate(),
          event_type: "sender.message_converter",
          client: "teste",
          currencie_from: "USD",
          currencie_to: "BRL",
          value_to_convert: "50",
          value_converted: "256" }

  """

  @spec send_message(%{
          :client => String.t(),
          :currencie_from => String.t(),
          :currencie_to => String.t(),
          :event_type => String.t(),
          :message_id => String.t(),
          :value_converted => String.t(),
          :value_to_convert => String.t(),
          :schedule_at => String.t()
        }) :: {:error, any()} | {:ok, :message_send}
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
          "value_converted" => data.value_converted,
          "schedule_at" => data.schedule_at
        }
        |> Jason.encode!()
    }
  end
end
