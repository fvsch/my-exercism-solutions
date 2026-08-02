defmodule Dominoes do
  @type stone :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(stones :: [stone]) :: boolean
  def chain?([]), do: true

  def chain?(stones) do
    len = length(stones)

    stones
    |> make_chains()
    |> Enum.filter(&(length(&1) == len))
    |> Enum.any?(&closed_chain?/1)
  end

  defp make_chains(stones) do
    len = length(stones)

    Range.to_list(0..(len - 1))
    |> permute(len)
    |> Enum.map(fn indexes -> Enum.map(indexes, &Enum.at(stones, &1)) end)
    |> Enum.flat_map(&continuous_chains/1)
  end

  defp continuous_chains(stones) do
    len = length(stones)
    flipped = List.update_at(stones, 0, &flip/1)

    [
      Enum.reduce_while(stones, [], &push_stone/2),
      Enum.reduce_while(flipped, [], &push_stone/2)
    ]
    |> Enum.filter(&(length(&1) == len))
    |> Enum.filter(&closed_chain?/1)
  end

  defp flip({a, b}), do: {b, a}

  defp permute([], _), do: [[]]
  defp permute(_, 0), do: [[]]

  defp permute(list, i) do
    for item <- list, sublist <- permute(list -- [item], i - 1) do
      [item | sublist]
    end
  end

  # Add a stone to a list if it can be linked to the previous stone,
  # as-is or flipped.
  defp push_stone(stone, []), do: {:cont, [stone]}
  defp push_stone({_, x} = stone, [{x, _} | _] = acc), do: {:cont, [stone | acc]}
  defp push_stone({x, _} = stone, [{x, _} | _] = acc), do: {:cont, [flip(stone) | acc]}
  defp push_stone(_stone, acc), do: {:halt, acc}

  defp closed_chain?(chain) do
    case {List.first(chain), List.last(chain)} do
      {{x, _}, {_, x}} -> true
      _ -> false
    end
  end
end
