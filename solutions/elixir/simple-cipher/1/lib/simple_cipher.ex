defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    rotate_text(plaintext, key, :asc)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    rotate_text(ciphertext, key, :desc)
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    1..length
    |> Enum.map(fn _n -> Enum.random(?a..?z) end)
    |> to_string()
  end

  defp key_offsets(key, sign) when sign == 1 or sign == -1 do
    if String.match?(key, ~r/^[a-z]+$/) do
      key
      |> String.to_charlist()
      |> Enum.map(fn char -> (char - ?a) * sign end)
    else
      raise("invalid key")
    end
  end

  defp rotate_text(text, key, direction) when direction == :asc or direction == :desc do
    offsets = key_offsets(key, if(direction == :asc, do: 1, else: -1))

    String.to_charlist(text)
    |> Enum.chunk_every(length(offsets))
    |> Enum.flat_map(fn chunk -> Enum.zip_with(chunk, offsets, &rotate_char/2) end)
    |> to_string()
  end

  defp rotate_char(char, offset) when char in ?a..?z, do: fit_in_range(?a..?z, char + offset)
  defp rotate_char(char, offset) when char in ?A..?Z, do: fit_in_range(?A..?Z, char + offset)
  defp rotate_char(char, _), do: char

  defp fit_in_range(%Range{first: a, last: b, step: 1}, num)
       when a < b and num >= a and num <= b,
       do: num

  defp fit_in_range(%Range{first: a, last: b, step: 1} = range, num) when a < b do
    index = rem(num - a, Range.size(range))
    Enum.at(range, index)
  end
end
