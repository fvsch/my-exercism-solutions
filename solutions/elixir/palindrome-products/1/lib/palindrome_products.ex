defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when min_factor > max_factor do
    raise ArgumentError, "min_factor must be lower than max_factor"
  end

  def generate(max_factor, min_factor) do
    Enum.reduce(min_factor..max_factor, %{}, fn x, map ->
      Enum.reduce(x..max_factor, map, fn y, map -> reduce(map, x * y, x, y) end)
    end)
  end

  defp reduce(map, product, x, y) when is_map_key(map, product) do
    Map.update(map, product, [], &[sort_factors(x, y) | &1])
  end

  defp reduce(map, product, x, y) do
    if palindrome?(product) do
      Map.put(map, product, [sort_factors(x, y)])
    else
      map
    end
  end

  defp sort_factors(x, y), do: [min(x, y), max(x, y)]

  defp palindrome?(num) when num > 0 and num < 10, do: true
  defp palindrome?(num) when rem(num, 10) == 0, do: false
  defp palindrome?(num) when num < 100, do: rem(num, 11) == 0

  defp palindrome?(num) do
    num
    |> Integer.digits()
    |> then(&(&1 == Enum.reverse(&1)))
  end
end
