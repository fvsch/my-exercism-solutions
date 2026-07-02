defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = String.downcase(base)
    base_sorted = sort_letters(base)

    Enum.filter(candidates, fn word ->
      word = String.downcase(word)
      word_sorted = sort_letters(word)
      word != base && word_sorted == base_sorted
    end)
  end

  defp sort_letters(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join()
  end
end
