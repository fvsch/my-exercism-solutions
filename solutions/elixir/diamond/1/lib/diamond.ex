defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()

  def build_shape(letter) when letter in ?A..?Z do
    x_chars = char_axis(letter, ?A)
    y_chars = char_axis(?A, letter)

    y_chars
    |> Enum.map(&print_line(x_chars, &1))
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp char_axis(char, char), do: [char]

  defp char_axis(first, last) do
    forward = Range.new(first, last, if(first < last, do: 1, else: -1)) |> Enum.to_list()
    back = forward |> Enum.slice(0..-2//1) |> Enum.reverse()
    forward ++ back
  end

  defp print_line(letters, letter) do
    letters
    |> Enum.map(&if(&1 == letter, do: &1, else: ?\s))
    |> List.to_string()
  end
end
