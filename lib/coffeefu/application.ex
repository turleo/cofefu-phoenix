defmodule Coffeefu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CoffeefuWeb.Telemetry,
      Coffeefu.Repo,
      {DNSCluster, query: Application.get_env(:coffeefu, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Coffeefu.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Coffeefu.Finch},
      # Start a worker by calling: Coffeefu.Worker.start_link(arg)
      # {Coffeefu.Worker, arg},
      # Start to serve requests, typically the last entry
      CoffeefuWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Coffeefu.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoffeefuWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
