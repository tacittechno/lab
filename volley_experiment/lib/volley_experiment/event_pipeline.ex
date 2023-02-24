defmodule VolleyExperiment.EventPipeline do
  use Broadway
  require Logger

  def start_link(_args) do
    Broadway.start_link(__MODULE__, [
      name: VolleyExperiment.EventPipeline,
      producer: [
        module: {
          Volley.InOrderSubscription, [
            name: VolleyExperiment.Producer,
            connection: VolleyExperiment.Client,
            stream_name: "test-stream",
            restore_stream_position!: fn -> :start end
          ]
        },
        transformer: {VolleyExperiment.EventPipeline, :transform, []},
        concurrency: 1
      ],
      processors: [
        default: [max_demand: 1, concurrency: 1]
      ],
    ])
  end

  def handle_message(_processor, message, _context) do
    Logger.info("Receieved message: #{inspect(message)}")
    message
  end

  def transform(event, _opts) do
    %Broadway.Message{
      data: event,
      acknowledger: {VolleyExperiment.EventPipeline, :events, []}
    }
  end

  def ack(:events, _sucessful, _failed) do
    :ok
  end
end
