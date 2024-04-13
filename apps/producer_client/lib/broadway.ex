defmodule Broadway do
  require Logger

  alias ProducerClient.BroadwayMessage.Producer
  alias ProducerClient.Client.Converter

  def broadway_message(
        %{
          currencie_from: currencie_from,
          currencie_to: currencie_to,
          value_to_convert: value_to_convert
        } = params
      ) do
    broadway_message_builded =
      currencie_from
      |> Converter.converter_table(currencie_to, value_to_convert)
      |> build_broadway_message(params)

    case Producer.send_message(broadway_message_builded) do
      :ok ->
        Logger.info("Message was been produced to topic : currencie_converter")

      {:error, body} ->
        Logger.error("Message dosen`t produced for reaseon: #{body}")
        {:error, body}

      _errror ->
        Logger.error("Message dosen`t produced unknow reason")
        {:error, :unknow_reason}
    end
  end

  defp build_broadway_message(value_converted, %{value_to_convert: value_to_convert} = params)
       when is_integer(value_to_convert) do
    params
    |> Map.put(:value_to_convert, Integer.to_string(params.value_to_convert))
    |> Map.merge(value_converted)
    |> IO.inspect(label: :message)
  end

  defp build_broadway_message(value_converted, %{value_to_convert: value_to_convert} = params)
       when is_float(value_to_convert) do
    params
    |> Map.put(:value_to_convert, Float.to_string(params.value_to_convert))
    |> Map.merge(value_converted)
    |> IO.inspect(label: :message)
  end
end
