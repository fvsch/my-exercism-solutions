defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @alphabet ?a..?z

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(_key, ""), do: ""

  def encode(key, message) do
    with {:ok, ekey} <- extended_key(key, @alphabet) do
      message
      |> to_chars()
      |> Enum.map(&encode_char(&1, @alphabet, ekey))
      |> to_str(5)
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(key, encrypted) do
    with {:ok, ekey} <- extended_key(key, @alphabet),
         {:ok, mmi} <- get_mmi(ekey) do
      encrypted
      |> to_chars()
      |> Enum.map(&decode_char(&1, @alphabet, Map.put(ekey, :mmi, mmi)))
      |> to_str()
      |> then(&{:ok, &1})
    end
  end

  defp extended_key(%{a: a, b: _} = key, %Range{} = range) do
    m = Range.size(range)

    if Integer.gcd(a, m) == 1 do
      {:ok, Map.put(key, :m, m)}
    else
      {:error, "a and m must be coprime."}
    end
  end

  defp to_chars(str) do
    str
    |> String.downcase()
    |> String.replace(~r"[^a-z\d]+", "")
    |> String.to_charlist()
  end

  defp to_str(chars, group_size \\ 0) do
    cond do
      group_size < 1 ->
        Kernel.to_string(chars)

      true ->
        chars
        |> Enum.chunk_every(group_size)
        |> Enum.map(&Kernel.to_string/1)
        |> Enum.join(" ")
    end
  end

  defp encode_char(char, range, %{a: a, b: b, m: m}) do
    if char in range do
      i = char - range.first
      y = Integer.mod(a * i + b, m)
      y + range.first
    else
      char
    end
  end

  defp decode_char(char, range, %{b: b, m: m, mmi: mmi}) do
    if char in range do
      y = char - range.first
      i = Integer.mod(mmi * (y - b), m)
      i + range.first
    else
      char
    end
  end

  defp get_mmi(%{a: a, m: m}) do
    1..m
    |> Enum.find(fn x -> Integer.mod(a * x, m) == 1 end)
    |> then(fn
      nil -> {:error, "a and m must be coprime."}
      mmi -> {:ok, mmi}
    end)
  end
end
