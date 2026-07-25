defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()

  def build_shape(letter) when letter in ?A..?Z do
    x_chars = sequence(letter, ?A)
    y_chars = sequence(?A, letter)

    y_chars
    |> Enum.map(&print_line(x_chars, &1))
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp sequence(char, char), do: [char]

  defp sequence(first, last) do
    dir = if(first < last, do: 1, else: -1)
    forward = Range.new(first, last, dir) |> Enum.to_list()
    forward ++ tl(Enum.reverse(forward))
  end

  defp print_line(letters, letter) do
    letters
    |> Enum.map(&if(&1 == letter, do: &1, else: ?\s))
    |> List.to_string()
  end
end
