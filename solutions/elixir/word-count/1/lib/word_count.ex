defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    case Regex.scan(~r/[[:alnum:]']+/u, String.downcase(sentence)) do
      nil ->
        0

      [] ->
        0

      words ->
        words
        |> List.flatten()
        |> Enum.map(&String.replace(&1, ~r/(^'|'$)/, ""))
        |> Enum.reject(&(&1 == ""))
        |> Enum.frequencies()
    end
  end
end
