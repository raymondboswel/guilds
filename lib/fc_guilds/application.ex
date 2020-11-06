defmodule FcGuilds.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FcGuilds.Repo,
      # Start the Telemetry supervisor
      FcGuildsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FcGuilds.PubSub},
      # Start the Endpoint (http/https)
      FcGuildsWeb.Endpoint
      # Start a worker by calling: FcGuilds.Worker.start_link(arg)
      # {FcGuilds.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FcGuilds.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FcGuildsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
