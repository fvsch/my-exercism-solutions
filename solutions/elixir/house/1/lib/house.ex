defmodule House do
  @lines [
    "the house that Jack built",
    "the malt that lay in",
    "the rat that ate",
    "the cat that killed",
    "the dog that worried",
    "the cow with the crumpled horn that tossed",
    "the maiden all forlorn that milked",
    "the man all tattered and torn that kissed",
    "the priest all shaven and shorn that married",
    "the rooster that crowed in the morn that woke",
    "the farmer sowing his corn that kept",
    "the horse and the hound and the horn that belonged to"
  ]

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop//1
    |> Enum.map(&verse/1)
    |> Enum.join()
  end

  defp verse(num) when is_integer(num) and num >= 1 do
    @lines
    |> Enum.slice(0..(num - 1)//1)
    |> Enum.reverse()
    |> Enum.join(" ")
    |> then(&"This is #{&1}.\n")
  end
end
