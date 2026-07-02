defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when is_integer(number) and number > 0 and number < 4000 do
    digits = Integer.digits(number)

    Enum.join([
      print_num(Enum.at(digits, -4, 0), {"M", "M", "M"}),
      print_num(Enum.at(digits, -3, 0), {"C", "D", "M"}),
      print_num(Enum.at(digits, -2, 0), {"X", "L", "C"}),
      print_num(Enum.at(digits, -1, 0), {"I", "V", "X"})
    ])
  end

  @spec print_num(pos_integer, {String.t(), String.t(), String.t()}) :: String.t()
  defp print_num(count, chars)
  defp print_num(0, _), do: ""
  defp print_num(count, {one, one, one}), do: String.duplicate(one, count)

  defp print_num(count, {one, five, ten}) do
    cond do
      count == 4 -> one <> five
      count == 9 -> one <> ten
      count in 1..3 -> String.duplicate(one, count)
      count in 5..8 -> five <> String.duplicate(one, count - 5)
    end
  end
end
