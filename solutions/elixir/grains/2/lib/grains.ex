defmodule Grains do
  @range 1..64//1

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) when number in @range,
    do: {:ok, Integer.pow(2, number - 1)}

  def square(_) do
    {:error,
     "The requested square must be between #{@range.first} and #{@range.last} (inclusive)"}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok, Enum.reduce(@range, 0, fn n, acc -> acc + elem(square(n), 1) end)}
  end
end
