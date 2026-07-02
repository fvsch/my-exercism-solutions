defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(String.t(), integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&shift_char(&1, shift, ?a..?z))
    |> Enum.map(&shift_char(&1, shift, ?A..?Z))
    |> to_string()
  end

  @spec shift_char(integer, integer, Range.t()) :: integer
  defp shift_char(char, shift, range) do
    if char in range and range.step == 1 do
      min = range.first
      pos = Integer.mod(char - min + shift, Range.size(range))
      min + pos
    else
      char
    end
  end
end
