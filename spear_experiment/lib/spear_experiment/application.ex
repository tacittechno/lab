defmodule SpearExperiment.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {SpearExperiment.Client, []}
    ]
    opts = [strategy: :one_for_one, name: SpearExperiment.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
