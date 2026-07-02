defmodule ResistorColorTrio do
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
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([c1, c2, c3 | _]) do
    value = (color_value(c1) * 10 + color_value(c2)) * 10 ** color_value(c3)

    exp =
      value
      |> Integer.digits()
      |> Enum.reverse()
      |> Enum.find_index(&(&1 != 0)) || 0

    cond do
      exp >= 9 -> {div(value, 10 ** 9), :gigaohms}
      exp >= 6 -> {div(value, 10 ** 6), :megaohms}
      exp >= 3 -> {div(value, 10 ** 3), :kiloohms}
      true -> {value, :ohms}
    end
  end

  defp color_value(color) when is_map_key(@color_values, color) do
    @color_values[color]
  end
end
