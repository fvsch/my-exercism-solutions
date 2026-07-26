defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    if String.match?(number, ~r"^\d[\d ]*\d+$") do
      Integer.mod(number |> digits() |> sum(), 10) == 0
    else
      false
    end
  end

  defp digits(number) do
    number
    |> String.replace(~r"\D+", "")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp sum(digits) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.sum_by(fn
      {n, i} when rem(i, 2) == 0 -> n
      {n, _} when n >= 5 -> n * 2 - 9
      {n, _} -> n * 2
    end)
  end
end
