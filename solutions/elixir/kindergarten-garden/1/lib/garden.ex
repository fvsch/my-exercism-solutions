defmodule Garden do
  @students ~w"""
    alice bob charlie
    david eve fred
    ginny harriet ileana
    joseph kincaid larry
  """a

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    rows =
      info_string
      |> String.replace(~r"[^CGRV\s]+", "")
      |> String.split(~r"\s+", trim: true)

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.map(fn {name, index} -> {name, decode_rows(rows, index)} end)
    |> Map.new()
  end

  defp decode_rows(rows, index) do
    rows
    |> Enum.map_join(fn row -> String.slice(row, index * 2, 2) end)
    |> String.graphemes()
    |> Enum.map(&decode_plant/1)
    |> List.to_tuple()
  end

  defp decode_plant("C"), do: :clover
  defp decode_plant("G"), do: :grass
  defp decode_plant("R"), do: :radishes
  defp decode_plant("V"), do: :violets
end
