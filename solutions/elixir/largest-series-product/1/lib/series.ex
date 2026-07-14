defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(digits, size) do
    cond do
      size <= 0 ->
        raise ArgumentError, "size must be a positive integer"

      size > String.length(digits) ->
        raise ArgumentError, "size exceeds string length"

      !String.match?(digits, ~r"^\d+$") ->
        raise ArgumentError, "invalid digits string"

      true ->
        digits
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)
        |> Enum.chunk_every(size, 1, :discard)
        |> Enum.map(&Enum.product/1)
        |> Enum.max()
    end
  end
end
