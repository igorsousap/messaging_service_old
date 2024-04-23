defmodule Schema.Webhook do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields [
    :endpoint,
    :event_type,
    :client,
    :currencie_from,
    :currencie_to,
    :message_id,
    :value_to_convert,
    :value_converted,
    :schedule_at
  ]

  @primary_key false
  @derive {Jason.Encoder, only: @required_fields}
  embedded_schema do
    field(:endpoint, :string)
    field(:event_type, :string)
    field(:client, :string)
    field(:currencie_from, :string)
    field(:currencie_to, :string)
    field(:message_id, :string)
    field(:value_to_convert, :string)
    field(:value_converted, :string)
    field(:schedule_at, :naive_datetime, default: nil)
  end

  def changeset(message) do
    %__MODULE__{}
    |> cast(message, @required_fields)
    |> validate_required(@required_fields)
    |> apply_changes()
  end
end
