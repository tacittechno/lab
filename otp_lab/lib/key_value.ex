defmodule KeyValue do
  use GenServer

  # Process is restarted if crashes (default option)
  # use GenServer, restart: :permanent

  # Process is never restarted, any termination is considered successful
  # use GenServer, restart: :temporary

  # Process is restarted only if termination is abnormal, i.e., with an
  # exit reason other than `:normal`, `:shutdown` or `{:shutdown, term}`
  # use GenServer, restart: :transient

  require Logger

  def state() do
    GenServer.call(__MODULE__, {:state})
  end

  @spec get(String.t()) :: any()
  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  @spec set(String.t(), any()) :: :ok
  def set(key, value) do
    GenServer.cast(__MODULE__, {:set, key, value})
  end

  @spec del(String.t()) :: :ok
  def del(key) do
    GenServer.cast(__MODULE__, {:del, key})
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    Logger.info("#{inspect(__MODULE__)} server started")
    {:ok, %{}}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    case Map.fetch(state, key) do
      {:ok, value} ->
        {:reply, value, state}

      :error ->
        Logger.error("No key #{inspect(key)} in key-value store")
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:del, key}, state) do
    new_state = state |> Map.delete(key)
    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:set, key, value}, state) do
    if key == "error", do: raise "ERROR, ERROR"

    new_state = state |> Map.put(key, value)
    {:noreply, new_state}
  end
end
