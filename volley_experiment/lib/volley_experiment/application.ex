defmodule VolleyExperiment.Application do
  use Application

  def start(_type, _args) do
    children = [
      VolleyExperiment.Client,
      {
        Volley.InOrderSubscription,
        [
          name: VolleyExperiment.Producer,
          connection: VolleyExperiment.Client,
          stream_name: "test-stream",
          # restore_stream_position!: {VolleyExperiment.Handler, :fetch_stream_position!, []}
          restore_stream_position!: fn -> :start end
        ]
      },
      VolleyExperiment.Handler
    ]

    # :ets.new(:stream_positions, [:set, :public, :named_table])

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
