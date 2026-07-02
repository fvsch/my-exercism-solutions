defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: to_rna(dna, [])

  defp to_rna([], acc), do: Enum.reverse(acc)
  defp to_rna([x], acc), do: to_rna([], [d2n(x) | acc])
  defp to_rna([x | dna], acc), do: to_rna(dna, [d2n(x) | acc])

  defp d2n(?A), do: ?U
  defp d2n(?C), do: ?G
  defp d2n(?G), do: ?C
  defp d2n(?T), do: ?A
end
