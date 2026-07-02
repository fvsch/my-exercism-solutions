defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    prompt = String.trim(input)

    case {silent?(prompt), question?(prompt), allcaps?(prompt)} do
      {true, _, _} -> "Fine. Be that way!"
      {_, true, true} -> "Calm down, I know what I'm doing!"
      {_, true, false} -> "Sure."
      {_, false, true} -> "Whoa, chill out!"
      _ -> "Whatever."
    end
  end

  defp silent?(input), do: input == ""
  defp question?(input), do: String.ends_with?(input, "?")

  defp allcaps?(input) do
    letters = String.replace(input, ~r/[^[:alpha:]]/u, "")
    letters != "" && String.upcase(letters) == letters
  end
end
