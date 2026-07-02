defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @action_map %{
    0b0001 => "wink",
    0b0010 => "double blink",
    0b0100 => "close your eyes",
    0b1000 => "jump"
  }
  @reverse_mask 0b10000

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code < 1 or code > 32, do: []

  def commands(code) do
    actions =
      @action_map
      |> Map.filter(fn {mask, _} -> match_code?(code, mask) end)
      |> Enum.map(fn {_, label} -> label end)

    if match_code?(code, @reverse_mask),
      do: Enum.reverse(actions),
      else: actions
  end

  defp match_code?(code, mask), do: Bitwise.band(code, mask) == mask
end
