defmodule Transmission do
  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    encode(message, <<>>)
  end

  defp encode(<<>>, acc), do: acc

  defp encode(message, acc) when bit_size(message) <= 7 do
    acc <> add_parity_bit(message)
  end

  defp encode(<<a::7, rest::bitstring>>, acc) do
    next_byte = add_parity_bit(<<a::7>>)
    encode(rest, acc <> next_byte)
  end

  defp add_parity_bit(part) when bit_size(part) <= 7 do
    pad_size = 7 - bit_size(part)
    <<int::8>> = <<0::size(pad_size + 1), part::bitstring>>
    parity_bit = Integer.mod(Integer.popcount(int), 2)

    <<part::bitstring, 0::size(pad_size), parity_bit::size(1)>>
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
    decode(received_data, <<>>)
  end

  defp decode(<<>>, acc) do
    case rem(bit_size(acc), 8) do
      0 -> {:ok, acc}
      _ -> {:ok, truncate_bytes(acc)}
    end
  end

  defp decode(<<byte::binary-size(1), rest::binary>>, acc) do
    <<int>> = byte

    case Integer.popcount(int) do
      count when rem(count, 2) != 0 ->
        {:error, "wrong parity"}

      _ ->
        <<bits::bitstring-size(7), _parity::bitstring-size(1)>> = byte
        decode(rest, <<acc::bitstring, bits::bitstring>>)
    end
  end

  defp truncate_bytes(data) do
    count = div(bit_size(data), 8)
    <<bytes::binary-size(^count), _excess::bitstring>> = data
    bytes
  end
end
