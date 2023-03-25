defmodule DebugPhoenixJs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DebugPhoenixJsWeb.Telemetry,
      # Start the Ecto repository
      DebugPhoenixJs.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DebugPhoenixJs.PubSub},
      # Start Finch
      {Finch, name: DebugPhoenixJs.Finch},
      # Start the Endpoint (http/https)
      DebugPhoenixJsWeb.Endpoint
      # Start a worker by calling: DebugPhoenixJs.Worker.start_link(arg)
      # {DebugPhoenixJs.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DebugPhoenixJs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DebugPhoenixJsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
