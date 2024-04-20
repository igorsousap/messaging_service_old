defmodule Webhooks.WorkerMessage do
  use Oban.Worker

  require Logger

  alias Webhooks.ClientMessage

  @impl Oban.Worker
  @spec perform(Oban.Job.t()) ::
          {:error, :no_scheme | :not_send | :nxdomain} | {:ok, :success_send}
  def perform(%Oban.Job{
        args:
          %{
            "client" => client,
            "endpoint" => endpoint,
            "event_type" => event_type
          } = args
      }) do
    Logger.info(
      "Trying send message to #{endpoint}, from client: #{client} and event #{event_type}"
    )

    with {:ok, %Tesla.Env{status: 200}} <- ClientMessage.send_webhook(args, endpoint) do
      Logger.info(
        "Success send message to #{endpoint}, from client: #{client} and event #{event_type}"
      )

      {:ok, :success_send}
    else
      {:error, %Tesla.Env{status: status}} ->
        Logger.error("Cant send message status: #{status}")
        {:error, :not_send}

      {:error, {:no_scheme}} ->
        Logger.error("Cant send message {:error, :no_scheme}")
        {:error, :no_scheme}

      {:error, :nxdomain} ->
        Logger.error("Cant send message {:error, :nxdomain}")
        {:error, :nxdomain}
    end
  end
end
