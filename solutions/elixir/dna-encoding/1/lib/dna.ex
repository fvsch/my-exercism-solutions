defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna), do: do_encode(dna, <<>>)
  defp do_encode([] = _dna, bits), do: bits

  defp do_encode([char | tail] = _dna, bits) do
    do_encode(tail, <<bits::bitstring, encode_nucleotide(char)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])
  defp do_decode(<<>> = _dna, list), do: list

  defp do_decode(<<first::4, rest::bitstring>>, list) do
    do_decode(rest, list ++ [decode_nucleotide(first)])
  end
end
