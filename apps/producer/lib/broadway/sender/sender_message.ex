defmodule Broadway.Sender.SenderMessage do
  require Logger

  def send_message(data) do
    Logger.info("Starting to Produce Message")

    build_data =
      data
      |> build_message()

    case Kaffe.Producer.produce_sync("currencie_converter", build_data) do
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
    # %{endpoint: "teste.com", client: "teste", value_converted: "10"}
    data
    |> Enum.map(fn {key, value} -> {Atom.to_string(key), value} end)
    |> IO.inspect(label: :message)
  end
end
