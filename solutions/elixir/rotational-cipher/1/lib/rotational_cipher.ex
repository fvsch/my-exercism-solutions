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
    |> Enum.map(&shift_in_range(&1, {?a, ?z, shift}))
    |> Enum.map(&shift_in_range(&1, {?A, ?Z, shift}))
    |> to_string()
  end

  @spec shift_in_range(integer, {integer, integer, integer}) :: integer
  defp shift_in_range(num, {min, max, _}) when num < min or num > max, do: num

  defp shift_in_range(num, {min, max, shift}) do
    index = num - min + shift
    divisor = max - min + 1
    min + Integer.mod(index, divisor)
  end
end
