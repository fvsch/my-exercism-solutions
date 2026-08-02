defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, _workers) do
    texts
    |> Enum.map(&single_frequency/1)
    |> Enum.reduce(%{}, &merge_frequencies/2)
  end

  defp single_frequency(str) do
    str
    |> String.downcase()
    |> String.replace(~r{[\W\d]+}u, "")
    |> String.graphemes()
    |> Enum.reduce(%{}, &increment_count/2)
  end

  defp increment_count(char, counts) do
    Map.update(counts, char, 1, &(&1 + 1))
  end

  defp merge_frequencies(map1, map2) do
    Map.merge(map1, map2, fn _key, a, b -> a + b end)
  end
end
