defmodule TakeANumber do
  def start() do
    spawn(fn -> loop() end)
  end

  defp loop(state \\ 0) do
    receive do
      {:report_state, pid} ->
        send(pid, state)
        loop(state)

      {:take_a_number, pid} ->
        state = state + 1
        send(pid, state)
        loop(state)

      :stop ->
        nil

      _ ->
        loop(state)
    end
  end
end
