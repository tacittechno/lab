defmodule VolleyExperiment.Application do
  use Application

  def start(_type, _args) do
    children = [
      VolleyExperiment.Client,
      VolleyExperiment.EventPipeline
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
