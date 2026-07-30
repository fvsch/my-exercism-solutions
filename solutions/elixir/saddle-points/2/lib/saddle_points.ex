defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
    |> pad_rows()
  end

  defp parse_row(str) do
    str
    |> String.split(~r"\s+", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp pad_rows([]), do: []

  defp pad_rows(rows) do
    padding = Stream.cycle([0])
    len = rows |> Enum.map(&length/1) |> Enum.max()

    Enum.map(rows, fn
      row when length(row) < len -> Stream.concat(row, padding) |> Enum.take(len)
      row -> row
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str |> rows() |> transpose()
  end

  defp transpose([]), do: []
  defp transpose(rows_or_cols), do: Enum.zip_with(rows_or_cols, & &1)

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    rows_max = rows |> Enum.map(&Enum.max/1)
    cols_min = rows |> transpose() |> Enum.map(&Enum.min/1)

    for {row, y} <- Enum.with_index(rows),
        {value, x} <- Enum.with_index(row),
        value == Enum.at(rows_max, y) and value == Enum.at(cols_min, x),
        do: {y + 1, x + 1}
  end
end
