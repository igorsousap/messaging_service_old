defmodule Converter do
  require Logger
  alias ProducerMessage.TeslaClient.Client

  def converter_table(currencie_from, currencie_to, value_to_convert) do
    case Client.currencie(currencie_from) do
      {:ok, body} ->
        table_currencies = body["conversion_rates"]

        value_converted =
          value_to_convert * table_currencies[currencie_to]

        Logger.info(
          "Valued Converted from #{currencie_from} to #{currencie_to} with total value: #{value_converted}"
        )

        %{value_converted: Float.to_string(value_converted)}

      {:error, :unsuported_code} ->
        Logger.error("Currencie informed not find: unsuported_code")

        {:error, :unsuported_code}
    end
  end
end
