defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([word]), do: last(word) <> "\n"

  def recite([first | tail] = strings) do
    strings
    |> Enum.zip(tail)
    |> Enum.map_join("\n", &line/1)
    |> Kernel.<>("\n#{last(first)}\n")
  end

  defp line({a, b}), do: "For want of a #{a} the #{b} was lost."
  defp last(a), do: "And all for the want of a #{a}."
end
