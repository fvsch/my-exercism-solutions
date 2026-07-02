defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when is_integer(count) and count > 0, do: numbers([], count)
  def generate(_), do: raise(ArgumentError, "count must be specified as an integer >= 1")

  defp numbers(list, 0), do: Enum.reverse(list)
  defp numbers([], i), do: numbers([2], i - 1)
  defp numbers([a], i), do: numbers([1, a], i - 1)
  defp numbers([a, b | _] = list, i), do: numbers([a + b | list], i - 1)
end
