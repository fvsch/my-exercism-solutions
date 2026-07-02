defmodule Say do
  @min_int 0
  @max_int 10 ** 12 - 1
  @scales %{0 => "", 3 => "thousand", 6 => "million", 9 => "billion"}
  @digits ~w"zero one two three four five six seven eight nine"
  @teens ~w"ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen"
  @tys ~w"zero ten twenty thirty forty fifty sixty seventy eighty ninety"

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}

  def in_english(number) when number < @min_int or number > @max_int do
    {:error, "number is out of range"}
  end

  def in_english(number) when number < 10, do: {:ok, get_digit(number)}

  def in_english(number) do
    parts =
      @scales
      |> Map.filter(fn {exp, _} -> 10 ** exp <= number end)
      |> Enum.reverse()
      |> Enum.into([], fn {exp, suffix} ->
        spell_scale(slice_int(number, exp), suffix)
      end)

    {:ok, join_words(parts)}
  end

  defp join_words(words) do
    words |> Enum.filter(&(String.trim(&1) != "")) |> Enum.join(" ")
  end

  defp slice_int(number, offset_exp) do
    number
    |> div(10 ** offset_exp)
    |> rem(1000)
  end

  defp spell_scale(0, _suffix), do: ""

  defp spell_scale(scale_number, suffix) do
    digits = Integer.digits(scale_number)

    [
      spell_hundreds(Enum.at(digits, -3, 0)),
      spell_2digits(Enum.at(digits, -2, 0), Enum.at(digits, -1, 0)),
      suffix
    ]
    |> join_words()
  end

  defp spell_hundreds(digit) do
    if digit > 0 do
      get_digit(digit) <> " hundred"
    else
      ""
    end
  end

  defp spell_2digits(tens, digit) do
    case {tens, digit} do
      {0, 0} -> ""
      {0, a} -> get_digit(a)
      {b, 0} -> get_ty(b)
      {1, a} -> get_teen(a)
      {b, a} -> get_ty(b) <> "-" <> get_digit(a)
    end
  end

  defp get_digit(digit), do: Enum.at(@digits, digit, "")
  defp get_teen(digit), do: Enum.at(@teens, digit, "")
  defp get_ty(digit), do: Enum.at(@tys, digit, "")
end
