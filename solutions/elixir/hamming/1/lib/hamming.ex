defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2)

  def hamming_distance(s, s), do: {:ok, 0}

  def hamming_distance(s1, s2) when length(s1) != length(s2),
    do: {:error, "strands must be of equal length"}

  def hamming_distance(s1, s2) do
    {:ok, calc_distance(s1, s2)}
  end

  defp calc_distance(strand1, strand2, count \\ 0)
  defp calc_distance(s, s, count), do: count

  defp calc_distance([c1 | s1], [c2 | s2], count) do
    calc_distance(s1, s2, if(c1 != c2, do: count + 1, else: count))
  end
end
