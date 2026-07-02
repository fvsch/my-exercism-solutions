defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number, 2, [])
  end

  defp do_factors_for(number, factor, acc) do
    next = next_factor(number, factor)

    if is_integer(next) do
      do_factors_for(div(number, next), next, acc ++ [next])
    else
      acc
    end
  end

  defp next_factor(number, factor) when factor > number, do: nil

  defp next_factor(number, factor) do
    if rem(number, factor) == 0 do
      factor
    else
      next_factor(number, factor + 1)
    end
  end
end
