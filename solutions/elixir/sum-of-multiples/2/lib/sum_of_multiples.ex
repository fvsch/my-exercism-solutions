defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.filter(&(&1 > 0 && &1 < limit))
    |> Enum.flat_map(&multiples(&1, limit - 1))
    |> Enum.uniq()
    |> Enum.sum()
  end

  @spec multiples(non_neg_integer, non_neg_integer) :: list(non_neg_integer)
  defp multiples(factor, max), do: Range.to_list(factor..max//factor)
end
