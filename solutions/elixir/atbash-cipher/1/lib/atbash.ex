defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]+/, "")
    |> String.to_charlist()
    |> Enum.map(&rotate/1)
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(~r/[^a-z0-9]+/, "")
    |> String.to_charlist()
    |> Enum.map(&rotate/1)
    |> List.to_string()
  end

  @spec rotate(integer()) :: integer()
  def rotate(num) do
    if num in ?a..?z, do: ?a + ?z - num, else: num
  end
end
