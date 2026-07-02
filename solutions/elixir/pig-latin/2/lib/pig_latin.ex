defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.downcase()
    |> String.replace("qu", "Q")
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
    |> String.replace("Q", "qu")
  end

  defp translate_word(word) do
    if word =~ ~r/^([aeiou]+|xr|y[^aeiou])/i do
      word <> "ay"
    else
      case Regex.run(~r/^[^aeiou][^aeiouy]*/i, word, capture: :first) do
        [initial] -> String.replace_prefix(word, initial, "") <> initial <> "ay"
        _ -> word <> "ay"
      end
    end
  end
end
