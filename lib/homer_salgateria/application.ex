defmodule HomerSalgateria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HomerSalgateriaWeb.Telemetry,
      HomerSalgateria.Repo,
      {DNSCluster, query: Application.get_env(:homer_salgateria, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HomerSalgateria.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HomerSalgateria.Finch},
      # Start a worker by calling: HomerSalgateria.Worker.start_link(arg)
      # {HomerSalgateria.Worker, arg},
      # Start to serve requests, typically the last entry
      HomerSalgateriaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HomerSalgateria.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HomerSalgateriaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
