defmodule MatchingBrackets do
  @bracket_pairs ["[]", "{}", "()"]
  @open_brackets Enum.map(@bracket_pairs, &String.at(&1, 0))
  @close_brackets Enum.map(@bracket_pairs, &String.at(&1, 1))

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r"[^{}()\[\]]+", "")
    |> String.graphemes()
    |> matched?([])
  end

  # open brackets queue must be empty once all signs are processed
  defp matched?([], open) do
    length(open) == 0
  end

  # open brackets get queued up
  defp matched?([char | rest], open) when char in @open_brackets do
    matched?(rest, [char | open])
  end

  # close brackets  must match the latest open bracket
  defp matched?([char | rest], open) when char in @close_brackets do
    case open do
      [prev | _] when (prev <> char) in @bracket_pairs -> matched?(rest, tl(open))
      _ -> false
    end
  end
end
