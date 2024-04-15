defmodule Producer.RegisterUserController do
  use Producer, :controller
  alias RegisterUser

  plug :accepts, ~w(json ...)

  def register_user(conn, params) do
    case RegisterUser.register_user(params) do
      {:error, error} ->
        render(conn, :index, %{error: error})

      {:ok, body} ->
        render(conn, :index, %{message: body})
    end
  end

  def update_user(conn, params) do
    case RegisterUser.update_client(params) do
      {:error, error} ->
        render(conn, :index, %{error: error})

      {:ok, body} ->
        render(conn, :index, %{message: body})
    end
  end

  def get_user(conn, params) do
    case RegisterUser.get_user(params) do
      {:error, error} ->
        render(conn, :index, %{error: error})

      body ->
        render(conn, :index_get, %{message: body})
    end
  end
end
