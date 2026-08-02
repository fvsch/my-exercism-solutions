defmodule FoodChain do
  @parts %{
    1 => %{
      animal: "fly",
      note: "I don't know why she swallowed the fly. Perhaps she'll die."
    },
    2 => %{
      animal: "spider",
      note: "It wriggled and jiggled and tickled inside her.",
      next: "the fly"
    },
    3 => %{
      animal: "bird",
      note: "How absurd to swallow a bird!",
      next: "the spider that wriggled and jiggled and tickled inside her"
    },
    4 => %{
      animal: "cat",
      note: "Imagine that, to swallow a cat!",
      next: "the bird"
    },
    5 => %{
      animal: "dog",
      note: "What a hog, to swallow a dog!",
      next: "the cat"
    },
    6 => %{
      animal: "goat",
      note: "Just opened her throat and swallowed a goat!",
      next: "the dog"
    },
    7 => %{
      animal: "cow",
      note: "I don't know how she swallowed a cow!",
      next: "the goat"
    },
    8 => %{
      animal: "horse",
      note: "She's dead, of course!"
    }
  }

  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop//1
    |> Enum.map(&verse/1)
    |> Enum.join("\n\n")
    |> Kernel.<>("\n")
  end

  defp verse(index) when index > 0 and index <= 8 do
    Range.new(index, if(index == 8, do: index, else: 1), -1)
    |> Enum.map(&Map.get(@parts, &1))
    |> Enum.reduce_while([], &render_lines/2)
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  defp render_lines(%{animal: a, note: note, next: next}, lines) do
    case lines do
      [] -> {:cont, [start_line(a) <> "\n" <> note <> "\n" <> catch_line(a, next)]}
      _ -> {:cont, [catch_line(a, next) | lines]}
    end
  end

  defp render_lines(%{animal: a, note: note}, lines) do
    case lines do
      [] -> {:halt, [start_line(a) <> "\n" <> note]}
      _ -> {:halt, [note | lines]}
    end
  end

  defp start_line(animal), do: "I know an old lady who swallowed a #{animal}."
  defp catch_line(animal, line_end), do: "She swallowed the #{animal} to catch #{line_end}."
end
