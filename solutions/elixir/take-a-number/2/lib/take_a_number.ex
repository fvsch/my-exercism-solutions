defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(state \\ 0) do
    receive do
      {:report_state, pid} -> send(pid, state) |> loop()
      {:take_a_number, pid} -> send(pid, state + 1) |> loop()
      :stop -> nil
      _ -> loop(state)
    end
  end
end
