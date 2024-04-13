defmodule ProducerClient.BroadwayMessage.Producer do
  require Logger

  def send_message(data) do
    Logger.info("Starting to Produce Message")

    build_data =
      data
      |> build_message()

    Kaffe.Producer.produce_sync("currencie_converter", build_data)
  end

  defp build_message(data) do
    # %{endpoint: "teste.com", client: "teste", value_converted: "10"}
    data
    |> Enum.map(fn {key, value} -> {Atom.to_string(key), value} end)
    |> IO.inspect(label: :message)
  end
end
