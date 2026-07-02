defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(&encode_chunk/1)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.split(~r"\d+[^\d]", include_captures: true)
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&decode_chunk/1)
    |> Enum.join()
  end

  defp encode_chunk([char]), do: char
  defp encode_chunk([char | _] = list), do: "#{length(list)}#{char}"

  defp decode_chunk(str) do
    if String.length(str) < 2 do
      str
    else
      case Regex.run(~r"^(?<num>\d+)(?<char>[^\d])$", str, capture: ~w(num char)) do
        [num, char] -> String.duplicate(char, String.to_integer(num))
        _ -> str
      end
    end
  end
end
