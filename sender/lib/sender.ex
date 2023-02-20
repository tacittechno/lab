defmodule Sender do
  def send_email("error@email.com") do
    {:error, "error@email.com"}
  end

  def send_email(email) do
    IO.puts("Sending email to #{email}...")
    Process.sleep(3000)
    {:ok, email}
  end

  def notify_all(emails) do
    emails
    |> Task.async_stream(&send_email/1, max_concurrency: 4)
    |> Enum.to_list()
  end

  def notify_nolink(emails) do
    Sender.EmailTaskSupervisor
    |> Task.Supervisor.async_stream_nolink(emails, &send_email/1)
    |> Enum.to_list()
  end
end
