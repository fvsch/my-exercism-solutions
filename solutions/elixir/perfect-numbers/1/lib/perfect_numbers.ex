defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0 do
    {:error, "Classification is only possible for natural numbers."}
  end

  def classify(number) do
    case {number, aliquot_sum(number)} do
      {a, a} -> {:ok, :perfect}
      {a, b} when a < b -> {:ok, :abundant}
      {_, _} -> {:ok, :deficient}
    end
  end

  defp aliquot_sum(number) do
    factors_for(number)
    |> Enum.filter(&(&1 != number))
    |> Enum.sum()
  end

  defp factors_for(number) do
    max_factor = max(1, div(number, 2))
    for x <- 1..max_factor, rem(number, x) == 0, do: x
  end
end
