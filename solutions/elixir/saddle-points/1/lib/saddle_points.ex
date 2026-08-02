defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    rows =
      str
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_row/1)

    lengths = Enum.uniq(Enum.map(rows, &length/1))

    if length(lengths) > 1 do
      max_length = Enum.max(lengths)
      Enum.map(rows, &pad_row(&1, max_length))
    else
      rows
    end
  end

  defp parse_row(str) do
    str
    |> String.split(~r"\s+", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp pad_row(row, target_length) when length(row) < target_length do
    row ++ Enum.map(1..(target_length - length(row)), fn _ -> 0 end)
  end

  defp pad_row(row, _), do: row

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> to_columns()
  end

  defp to_columns([]), do: []

  defp to_columns([first | _] = rows) do
    y_range = 0..(length(rows) - 1)
    x_range = 0..(length(first) - 1)

    Enum.map(x_range, fn x ->
      Enum.map(y_range, fn y ->
        rows
        |> Enum.at(y, [])
        |> Enum.at(x, 0)
      end)
    end)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    cols_min = Enum.map(to_columns(rows), &Enum.min/1)

    rows
    |> Enum.with_index()
    |> Enum.map(fn {row, row_index} -> {row, row_index, Enum.max(row)} end)
    |> Enum.flat_map(fn {row, row_index, highest} ->
      row
      |> Enum.with_index()
      |> Enum.filter(fn {value, col_index} ->
        value == highest and value == Enum.at(cols_min, col_index)
      end)
      |> Enum.map(fn {_, col_index} -> {row_index + 1, col_index + 1} end)
    end)
  end
end
