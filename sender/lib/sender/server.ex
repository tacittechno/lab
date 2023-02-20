defmodule Sender.Server do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(args) do
    IO.puts("Received args: #{inspect(args)}")
    max_retries = Keyword.get(args, :max_retries, 5)
    state = %{emails: [], max_retries: max_retries}
    # Every 5 seconds, retry failed emails
    Process.send_after(self(), :retry, 5000)
    {:ok, state}
  end

  @impl true
  def handle_call(:get_state, {from_pid, _}, state) do
    IO.puts("Received call from: #{inspect(from_pid)}")
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:send, email}, state) do
    case Sender.send_email(email) do
      {:ok, _} ->
        IO.puts("Sent email to #{inspect(email)}")
        emails = [%{email: email, status: "sent", retries: 0}] ++ state.emails
        {:noreply, %{state | emails: emails}}

      {:error, _} ->
        IO.puts("Failed to send email to #{inspect(email)}")
        emails = [%{email: email, status: "failed", retries: 0}] ++ state.emails
        {:noreply, %{state | emails: emails}}
    end
  end

  @impl true
  def handle_info(:retry, state) do
    {failed, done} =
      Enum.split_with(state.emails, fn item ->
        item.status === "failed" && item.retries < state.max_retries
      end)

    retried =
      Enum.map(failed, fn item ->
        IO.puts("Retrying email for: #{inspect(item.email)}")

        new_status =
          case Sender.send_email(item.email) do
            {:ok, _} -> "sent"
            {:error, _} -> "failed"
          end

        %{email: item.email, status: new_status, retries: item.retries + 1}
      end)

    Process.send_after(self(), :retry, 5000)

    {:noreply, %{state | emails: retried ++ done}}
  end

  @impl true
  def terminate(reason, _state) do
    IO.puts("Server terminating: #{inspect(reason)}")
  end
end
