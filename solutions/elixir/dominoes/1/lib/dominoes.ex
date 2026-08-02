defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true

  def chain?(dominoes) do
    len = length(dominoes)

    dominoes
    |> make_chains([])
    |> Enum.filter(&(length(&1) == len))
    |> Enum.any?(&closed_chain?/1)
  end

  # Start chains using each unique domino in both positions (normal and flipped)
  defp make_chains(dominoes, []) do
    set1 = Enum.zip(dominoes, dominoes)
    set2 = Enum.zip(Enum.map(dominoes, &flip/1), dominoes)

    (set1 ++ set2)
    |> Enum.uniq_by(fn {x, _} -> x end)
    |> Enum.map(fn {x, domino} -> make_chains(dominoes -- [domino], [x, nil]) end)
    |> unwrap()
  end

  defp make_chains([], chain), do: chain

  defp make_chains(dominoes, chain) do
    dominoes
    |> Enum.filter(&can_connect?(chain, &1))
    |> Enum.map(fn d -> make_chains(dominoes -- [d], push(chain, d)) end)
  end

  # I don't know how I can branch out and create new chains without
  # recursion creating deeply nested lists. So I'm cheating by making
  # each chain end with a separator, flattening everything and then
  # slicing into N chunks
  defp unwrap(chains) do
    chains
    |> List.flatten(chains)
    |> Enum.chunk_while([], &chunk_on_nil/2, &drop_empty_chunk/1)
  end

  defp chunk_on_nil(nil, acc), do: {:cont, Enum.reverse(acc), []}
  defp chunk_on_nil(x, acc), do: {:cont, [x | acc]}
  defp drop_empty_chunk([]), do: {:cont, []}
  defp drop_empty_chunk(acc), do: {:cont, acc, []}

  defp flip({a, b}), do: {b, a}

  defp can_connect?(chain, domino)
  defp can_connect?([nil], {_, _}), do: true
  defp can_connect?([{num, _} | _], {a, b}), do: num == a or num == b

  defp push([nil], domino), do: [domino]
  defp push([{a, _} | _] = chain, {_, a} = domino), do: [domino | chain]
  defp push([{a, _} | _] = chain, {a, _} = domino), do: [flip(domino) | chain]

  defp closed_chain?(chain) do
    case {List.first(chain), List.last(chain)} do
      {{x, _}, {_, x}} -> true
      _ -> false
    end
  end
end
