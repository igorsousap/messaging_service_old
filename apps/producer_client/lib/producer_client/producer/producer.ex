defmodule ProducerClient.Producer.Producer do
  def send_message("currencie_converter", data) do
    Kaffe.Producer.producer_synv("currencie_converter", [data])
  end
end
