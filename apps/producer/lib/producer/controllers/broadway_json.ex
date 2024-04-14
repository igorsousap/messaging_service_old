defmodule Producer.BroadwayJSON do
  def index(%{message: :sucess_send}) do
    "success send"
  end

  def index(%{error: reason}) do
    reason
  end
end
