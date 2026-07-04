defmodule MatchingBrackets do
  @bracket_pairs %{"(" => ")", "[" => "]", "{" => "}"}
  @bracket_list Map.keys(@bracket_pairs) ++ Map.values(@bracket_pairs)

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> Enum.filter(&(&1 in @bracket_list))
    |> Enum.reduce_while([], &reduce_open/2)
    |> Enum.empty?()
  end

  # Open bracket: queue up the matching close bracket
  defp reduce_open(char, queue) when is_map_key(@bracket_pairs, char),
    do: {:cont, [Map.get(@bracket_pairs, char) | queue]}

  # Close bracket should match and cancel out the latest queued item
  defp reduce_open(char, [char | rest]), do: {:cont, rest}

  # Any other case is a mismatched close bracket
  defp reduce_open(char, queue), do: {:halt, [char | queue]}
end
