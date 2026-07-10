defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str
    |> normalize()
    |> do_encode()
  end

  defp normalize(str) do
    str
    |> String.replace(~r/[^a-zA-Z\d]+/, "")
    |> String.downcase()
  end

  defp dimensions(count) do
    case ceil(:math.sqrt(count)) do
      w when w * (w - 1) >= count -> {w, w - 1}
      w -> {w, w}
    end
  end

  defp do_encode(""), do: ""

  defp do_encode(str) do
    {cols, rows} = dimensions(String.length(str))

    for i <- 0..(cols - 1) do
      Enum.map_join(0..(rows - 1), "", fn j -> String.at(str, cols * j + i) || " " end)
    end
    |> Enum.join(" ")
  end
end
