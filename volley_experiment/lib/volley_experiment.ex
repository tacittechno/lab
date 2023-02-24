defmodule VolleyExperiment do
  require Logger

  def append(stream_name, type, data) do
    conn = Process.whereis(VolleyExperiment.Client)
    event = Spear.Event.new(type, data)
    case Spear.append([event], conn, stream_name) do
      {:error, reason} ->
        Logger.error("Failed to append event to stream: #{inspect(stream_name)}")
        Logger.error("Reason: #{inspect(reason)}")
      :ok ->
        Logger.info("Event appended to stream: #{inspect(stream_name)}")
    end
  end

  def get_stream(stream_name) do
    VolleyExperiment.Client
    |> Process.whereis()
    |> Spear.stream!(stream_name)
    |> Enum.to_list()
  end
end
