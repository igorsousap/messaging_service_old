defmodule Webhooks.WorkerMessage do
  use Oban.Worker, max_attempts: 4

  require Logger

  alias Webhooks.ClientMessage

  @impl Oban.Worker
  @spec perform(Oban.Job.t()) ::
          {:error, :no_scheme | :not_send | :nxdomain} | {:ok, :success_send}
  def perform(
        %Oban.Job{
          args:
            %{
              "client" => client,
              "endpoint" => endpoint,
              "event_type" => event_type
            } = data,
          attempt: attempt
        } = args
      ) do
    Logger.info(
      "Trying send message to #{endpoint}, from client: #{client} and event #{event_type} at attempt #{attempt}"
    )

    IO.inspect(args, label: :args)

    with {:ok, %Tesla.Env{status: 200}} <- ClientMessage.send_webhook(data, endpoint) do
      Logger.info(
        "Success send message to #{endpoint}, from client: #{client} and event #{event_type}, at attempt: #{attempt}"
      )

      {:ok, :success_send}
    else
      {:ok, %Tesla.Env{status: status}} ->
        Logger.error("Cant send message status: #{status}, attempt: #{attempt}")
        {:error, :not_send}

      {:error, {:no_scheme}} ->
        Logger.error("Cant send message {:error, :no_scheme}, attempt: #{attempt}")
        {:error, :no_scheme}

      {:error, :nxdomain} ->
        Logger.error("Cant send message {:error, :nxdomain}, attempt: #{attempt}")
        {:error, :nxdomain}
    end
  end
end
