defmodule OpenWhc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OpenWhcWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:open_whc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OpenWhc.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: OpenWhc.Finch},
      # Start a worker by calling: OpenWhc.Worker.start_link(arg)
      # {OpenWhc.Worker, arg},
      # Start to serve requests, typically the last entry
      OpenWhcWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OpenWhc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OpenWhcWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
