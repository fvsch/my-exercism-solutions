defmodule Transpose do
  @padding_char "\u00B7"

  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    input
    |> to_matrix()
    |> transpose_matrix()
    |> print_matrix()
  end

  defp to_matrix(str) do
    str
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end

  defp transpose_matrix([]), do: []

  defp transpose_matrix(lines) do
    col_count = lines |> Enum.map(&length/1) |> Enum.max()

    for x <- 0..(col_count - 1)//1 do
      Enum.map(lines, &Enum.at(&1, x, @padding_char))
    end
  end

  defp print_matrix(lines) do
    lines
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.trim_trailing(&1, @padding_char))
    |> Enum.join("\n")
    |> String.replace(@padding_char, " ")
  end
end
