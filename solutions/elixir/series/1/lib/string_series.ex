defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size < 1, do: []
  def slices(s, size), do: do_slices(s, size)

  defp do_slices(s, size, acc \\ []) do
    case {String.length(s), size} do
      {len, size} when len < size ->
        acc

      {len, size} when len == size ->
        acc ++ [s]

      {len, size} when len > size ->
        current = String.slice(s, 0..(size - 1))
        next = String.slice(s, 1..-1//1)
        do_slices(next, size, acc ++ [current])
    end
  end
end
