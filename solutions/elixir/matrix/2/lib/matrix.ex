defmodule Matrix do
  @enforce_keys [:rows]
  defstruct rows: []

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  def from_string(input) do
    rows =
      input
      |> String.split("\n")
      |> Enum.map(&parse_line/1)

    %Matrix{rows: rows}
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  def to_string(%Matrix{rows: rows}) do
    rows
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  def rows(%Matrix{rows: rows}), do: rows

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  def row(%Matrix{rows: rows}, index) when is_integer(index) and index > 0 do
    rows
    |> Enum.at(index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  def columns(%Matrix{rows: rows}) do
    rows
    |> Enum.zip_with(& &1)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  def column(%Matrix{rows: rows}, index) when is_integer(index) and index > 0 do
    rows
    |> Enum.map(&Enum.at(&1, index - 1))
  end
end
