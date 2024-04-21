defmodule ProducerMessage do
  @moduledoc """
  Module whos process message and create the message to be sendo to kafka
  """
  require Logger
  alias Converter
  alias ProducerMessage.Sender.SenderMessage

  @doc """
  Process the message and create the map with the information necessary to be sendo to kafka
  ## Examples

      iex> ProducerMessage.producer_message(%{
          client: "teste",
          event_type: "send.message.converter",
          currencie_from: "USD",
          currencie_to: "BRL",
          value_to_convert: 50
        })

  """

  @spec producer_message(%{
          :event_type => String.t(),
          :client => String.t(),
          :currencie_from => String.t(),
          :currencie_to => String.t(),
          :value_to_convert => Integer.t(),
          :schedule_at => String.t()
        }) :: {:error, any()} | {:ok, :message_send}
  def producer_message(
        %{
          currencie_from: currencie_from,
          currencie_to: currencie_to,
          value_to_convert: value_to_convert
        } = params
      ) do
    valued_converted = Converter.converter_table(currencie_from, currencie_to, value_to_convert)
    params = Map.put(params, :message_id, Ecto.UUID.autogenerate())

    case valued_converted do
      {:error, :unsuported_code} ->
        {:error, :unsuported_code}

      _ ->
        build_message(valued_converted, params)
        |> SenderMessage.send_message()
    end
  end

  defp build_message(value_converted, %{value_to_convert: value_to_convert} = params)
       when is_integer(value_to_convert) do
    params
    |> Map.put(:value_to_convert, Integer.to_string(params.value_to_convert))
    |> Map.merge(value_converted)
  end

  defp build_message(value_converted, %{value_to_convert: value_to_convert} = params)
       when is_float(value_to_convert) do
    params
    |> Map.put(:value_to_convert, Float.to_string(params.value_to_convert))
    |> Map.merge(value_converted)
  end
end
