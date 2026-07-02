defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance = sqrt(x * x + y * y)

    cond do
      distance <= 1 -> 10
      distance <= 5 -> 5
      distance <= 10 -> 1
      true -> 0
    end
  end

  defp sqrt(num) when is_float(num), do: Float.pow(num, 0.5)
  defp sqrt(num) when is_integer(num), do: Float.pow(num * 1.0, 0.5)
end
