defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    digits = String.replace(isbn, "-", "")

    if String.match?(digits, ~r/^\d{9}[\dX]$/) do
      Integer.mod(isbn_sum(digits), 11) == 0
    else
      false
    end
  end

  @spec isbn_sum(String.t()) :: integer
  defp isbn_sum(digits) do
    digits
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.sum_by(fn {char, i} ->
      num = if char == "X", do: 10, else: String.to_integer(char)
      num * (i + 1)
    end)
  end
end
