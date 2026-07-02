defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 ->
        {:error, "input base must be >= 2"}

      output_base < 2 ->
        {:error, "output base must be >= 2"}

      Enum.any?(digits, &(&1 < 0 || &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        {:ok, digits |> to_int(input_base) |> to_digits(output_base)}
    end
  end

  @spec to_int(list, integer) :: integer
  defp to_int(digits, input_base) do
    last_index = length(digits) - 1

    digits
    |> Enum.with_index()
    |> Enum.map(fn {digit, index} -> {digit, last_index - index} end)
    |> Enum.reduce(0, fn {digit, exp}, acc ->
      acc + digit * input_base ** exp
    end)
  end

  @spec to_digits(integer, integer, list) :: list
  defp to_digits(number, base, acc \\ [])
  defp to_digits(0, _base, []), do: [0]
  defp to_digits(0, _base, acc), do: acc

  defp to_digits(number, base, acc) do
    digit = rem(number, base)
    next = div(number, base)
    to_digits(next, base, [digit | acc])
  end
end
