defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    0..(take_down - 1)
    |> Enum.map(&verse(start_bottle - &1))
    |> Enum.join("\n\n")
  end

  defp verse(num) when num > 0 do
    """
    #{bottle_name(num, true)} hanging on the wall,
    #{bottle_name(num, true)} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{bottle_name(num - 1)} hanging on the wall.\
    """
  end

  defp bottle_name(bottle_num, capitalize? \\ false) do
    name =
      case bottle_num do
        0 -> "no green bottles"
        1 -> "one green bottle"
        n -> spell_num(n) <> " green bottles"
      end

    if capitalize?, do: String.capitalize(name), else: name
  end

  @spelled_nums ~w"zero one two three four five six seven eight nine ten"
  defp spell_num(number) do
    Enum.at(@spelled_nums, number, "#{number}")
  end
end
