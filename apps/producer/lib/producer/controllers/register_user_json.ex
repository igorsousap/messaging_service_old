defmodule Producer.RegisterUserJSON do
  def index(%{message: body}) do
    body
  end

  def index(%{error: reason}) do
    reason
  end

  def index_get(%{message: reason}) do
    result =
      Enum.map(reason, fn body ->
        %{
          "id" => body.id,
          "event_type" => body.event_type,
          "client" => body.client,
          "endpoint" => body.endpoint
        }
      end)

    result
  end
end
