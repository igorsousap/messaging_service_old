defmodule ProducerClientWeb.BroadwayView do
  use ProducerClientWeb, :view

  def show(_conn, "show.json", params) do
    params
  end
end
