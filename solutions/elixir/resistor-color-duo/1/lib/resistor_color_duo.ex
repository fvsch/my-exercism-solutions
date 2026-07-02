defmodule ResistorColorDuo do
  @color_values %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([]), do: 0
  def value([c1]), do: color_value(c1)
  def value([c1 | [c2 | _]]), do: color_value(c1) * 10 + color_value(c2)

  defp color_value(color), do: @color_values[color]
end
