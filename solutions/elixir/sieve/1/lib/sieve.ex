defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit) do
    range = 3..limit//2
    candidates = [2 | Enum.to_list(range)]

    Enum.reduce(range, candidates, fn n, acc ->
      if n in acc do
        acc -- Enum.to_list(Range.new(n * 2, limit, n))
      else
        acc
      end
    end)
  end
end
