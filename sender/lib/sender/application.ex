defmodule Sender.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # {Sender.Worker, arg}
    ]

    opts = [strategy: :one_for_one, name: Sender.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
