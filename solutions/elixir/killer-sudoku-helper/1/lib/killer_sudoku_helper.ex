defmodule KillerSudokuHelper do
  @digits [1, 2, 3, 4, 5, 6, 7, 8, 9]

  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{size: 0}), do: []

  def combinations(%{exclude: exclude, size: 1, sum: sum}) do
    if sum in (@digits -- exclude), do: [[sum]], else: []
  end

  def combinations(%{size: size, sum: sum} = cage) when size > 1 do
    pool = digits_pool(cage)

    case length(pool) do
      len when len < size -> []
      len when len == size -> [pool]
      _ -> combine_all(pool, size)
    end
    |> Enum.filter(&(Enum.sum(&1) == sum))
    |> Enum.sort(&(Enum.join(&1) <= Enum.join(&2)))
  end

  # Remove excluded digits, and those too big
  # to be summed up with the smallest digits
  defp digits_pool(%{exclude: exclude, size: size, sum: sum}) when size > 1 do
    starting_pool = @digits -- exclude

    starting_pool
    |> Enum.filter(fn digit ->
      smallest = Enum.slice(starting_pool -- [digit], 0..(size - 2))
      digit + Enum.sum(smallest) <= sum
    end)
  end

  # Generate all lists of unique digits from a pool of digits
  # that match a given size.
  defp combine_all(pool, size) when size > 0 do
    # Start with a range of integers that represent all possible combinations
    # of the pool's digits when seen as series of n bits.
    Range.new(0, 2 ** length(pool) - 1)
    # Restrict the list to integers with `size` set bits
    |> Stream.filter(&(Integer.popcount(&1) == size))
    # Now map the set bits to their corresponding integer from pool
    |> Stream.map(&pick_with_bits(pool, &1))
    |> Enum.to_list()
  end

  defp pick_with_bits(pool, int) do
    bits = Integer.digits(int, 2) |> Enum.reverse()

    Enum.zip(pool, bits)
    |> Enum.filter(fn {_, bit} -> bit == 1 end)
    |> Enum.map(fn {digit, _} -> digit end)
  end
end
