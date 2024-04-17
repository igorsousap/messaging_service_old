defmodule Webhooks.WorkerMessage do
  use Oban.Worker, queue: :default, max_attempts: 4

  require Logger

  alias Webhooks.ClientMessage

  @impl Worker
  @spec perform(Oban.Job.t()) :: :ok | {:error, :not_send}
  def perform(%Oban.Job{args: %{attempt: attempt} = args}) do
    with {:ok, %Tesla.Env{status: 200}} <- ClientMessage.send_webhook(args) do
      Logger.info("Message was successfuly send to the endpoint ata attempt: #{attempt}")
    else
      {:error, %Tesla.Env{status: status}} ->
        Logger.error("Message will be try again: #{attempt} with status: #{status}")
        {:error, :not_send}
    end
  end
end
