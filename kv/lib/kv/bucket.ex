defmodule Kv.Bucket do
  use Agent

  @doc """
  Start a new bucket
  """
  def init do
    state = %{}
    with {:ok, _pid} <- Agent.start_link(fn -> state end, name: __MODULE__) do
      :ok
    end
  end

  @doc """
  Gets a value from the bucket by key
  """
  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def set(key, value) do
    Agent.update(__MODULE__, &Map.put(&1, key, value))
  end

  def del(key) do
    Agent.update(__MODULE__, &Map.delete(&1, key))
  end
end
