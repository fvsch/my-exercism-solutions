defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice), do: do_score(category, Enum.sort(dice))

  defp count(dice, num), do: Enum.count(dice, &(&1 == num))

  defp do_score(:ones, dice), do: count(dice, 1) * 1
  defp do_score(:twos, dice), do: count(dice, 2) * 2
  defp do_score(:threes, dice), do: count(dice, 3) * 3
  defp do_score(:fours, dice), do: count(dice, 4) * 4
  defp do_score(:fives, dice), do: count(dice, 5) * 5
  defp do_score(:sixes, dice), do: count(dice, 6) * 6
  defp do_score(:choice, dice), do: Enum.sum(dice)
  defp do_score(:yacht, [n, n, n, n, n]), do: 50
  defp do_score(:little_straight, [1, 2, 3, 4, 5]), do: 30
  defp do_score(:big_straight, [2, 3, 4, 5, 6]), do: 30

  defp do_score(:four_of_a_kind, [a, n, n, n, b]) do
    if n == a or n == b, do: 4 * n, else: 0
  end

  defp do_score(:full_house, [a, a, n, b, b] = dice) do
    if (n == a or n == b) and a < b, do: Enum.sum(dice), else: 0
  end

  defp do_score(_, _), do: 0
end
