defmodule ProducerClientWeb.BroadwayController do
  use ProducerClientWeb, :controller

  alias Broadway

  def send_message(conn, params) do
    message_build = build_params(params)

    case Broadway.broadway_message(message_build) do
      {:erro, :unknow_reason} ->
        render(conn, "show.json", :unknow_reason)

      {:erro, body} ->
        render(conn, "show.json", body)

      _ ->
        render(conn, "show.json", message_build)
    end
  end

  defp build_params(params) do
    %{
      endpoint: params["endpoint"],
      client: params["client"],
      currencie_from: params["currencie_from"],
      currencie_to: params["currencie_to"],
      value_to_convert: params["value_to_convert"]
    }
  end
end
