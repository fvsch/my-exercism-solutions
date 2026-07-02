defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    "#{name}, you are the #{number}#{ordinal_suffix(number)} customer we serve today. Thank you!"
  end

  defp ordinal_suffix(n) do
    case {rem(n, 10), rem(n, 100)} do
      {_, b} when b in 11..13 -> "th"
      {1, _} -> "st"
      {2, _} -> "nd"
      {3, _} -> "rd"
      _ -> "th"
    end
  end
end
