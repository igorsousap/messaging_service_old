defmodule Producer.Router do
  use Producer, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Producer do
    post "/convert_value", ProducerController, :send_message

    post "/user", RegisterUserController, :register_user
    put "/user/:id", RegisterUserController, :update_user
    get "/user/:client", RegisterUserController, :get_user

    pipe_through :api
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:producer, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: Producer.Telemetry
    end
  end
end
