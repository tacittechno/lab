defmodule VolleyExperiment.Handler do
  use GenStage
  require Logger

  # def fetch_stream_position! do
  #   case :ets.lookup(:stream_positions, __MODULE__) do
  #     [{__MODULE__, position}] -> position
  #     [] -> :start
  #   end
  # end

  def start_link(_args) do
    GenStage.start_link(__MODULE__, :ok)
  end

  @impl GenStage
  def init(:ok) do
    VolleyExperiment.Producer |> GenServer.whereis() |> Process.link()
    {:consumer, :ok, subscribe_to: [{VolleyExperiment.Producer, max_demand: 1}]}
  end

  @impl GenStage
  def handle_events(events, _from, state) do
    # Get current stream revision
    # revision = event.metadata.stream_revision
    # IO.inspect(revision, label: "handling event no.")

    # IO.inspect(inspect(events), label: "event")
    Logger.info("events: #{inspect(events)}")
    # Insert stream revision so Producer knowns where to start from in application startup
    # :ets.insert(:stream_positions, {__MODULE__, revision})
    {:noreply, [], state}
  end
end
