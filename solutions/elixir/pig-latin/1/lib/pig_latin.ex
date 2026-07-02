defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.downcase()
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    word = String.replace(word, "qu", "Q")

    if word =~ ~r/^([aeiou]+|xr|y[^aeiou])/i do
      word
    else
      case Regex.run(~r/^[^aeiou][^aeiouy]*/i, word, capture: :first) do
        [initial] -> String.replace(word, initial, "") <> initial
        _ -> word
      end
    end
    |> then(&(String.replace(&1, "Q", "qu") <> "ay"))
  end
end
