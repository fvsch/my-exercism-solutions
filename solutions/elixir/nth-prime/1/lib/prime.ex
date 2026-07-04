defmodule Prime do
  @first_ten [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

  @doc """
  Generates the nth prime.
  """
  @spec nth(pos_integer()) :: pos_integer()
  def nth(count) when is_integer(count) and count > 0 do
    primes(count)
    |> List.last()
  end

  defp primes(count) when count in 1..10 do
    Enum.slice(@first_ten, 0..(count - 1))
  end

  defp primes(count) when count > 10 do
    find_next(@first_ten, List.last(@first_ten) + 2, count - 10)
  end

  defp find_next(primes, _num, countdown) when countdown <= 0, do: primes

  defp find_next(primes, num, countdown) do
    next_num = num + 2

    if Enum.any?(primes, &(rem(num, &1) == 0)) do
      find_next(primes, next_num, countdown)
    else
      find_next(primes ++ [num], next_num, countdown - 1)
    end
  end
end
