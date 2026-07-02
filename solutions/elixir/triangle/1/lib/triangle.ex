defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    cond do
      !positive_sides?(a, b, c) -> {:error, "all side lengths must be positive"}
      !triangle_inequality?(a, b, c) -> {:error, "side lengths violate triangle inequality"}
      true -> {:ok, [a, b, c] |> Enum.uniq() |> length() |> kind_for()}
    end
  end

  @spec positive_sides?(number, number, number) :: boolean
  defp positive_sides?(a, b, c), do: a > 0 && b > 0 && c > 0

  @spec triangle_inequality?(number, number, number) :: boolean
  defp triangle_inequality?(a, b, c), do: a + b >= c && b + c >= a && a + c >= b

  @spec kind_for(unique_sides :: integer) :: kind
  defp kind_for(1), do: :equilateral
  defp kind_for(2), do: :isosceles
  defp kind_for(3), do: :scalene
end
