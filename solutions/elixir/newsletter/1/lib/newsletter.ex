defmodule Newsletter do
  def read_emails(path) do
    case File.read(path) do
      {:ok, text} -> parse_email_list(text)
      {:error, _} -> []
    end
  end

  def open_log(path) do
    File.open!(path, [:read, :write])
  end

  def log_sent_email(pid, email) do
    IO.write(pid, email <> "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)
    emails = read_emails(emails_path)

    Enum.map(emails, fn email ->
      with :ok <- send_fun.(email) do
        log_sent_email(log, email)
      end
    end)

    close_log(log)
  end

  defp parse_email_list(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 =~ "@"))
  end
end
