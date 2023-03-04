defmodule OtpLab.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {KeyValue, []}
    ]
    opts = [strategy: :one_for_one, name: OtpLab.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
