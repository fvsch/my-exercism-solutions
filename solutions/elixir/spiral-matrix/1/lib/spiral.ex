defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(1), do: [[1]]

  def matrix(dimension) do
    [{1, 0, 0}]
    |> add(:right, dimension)
    |> to_matrix(dimension)
  end

  defp to_matrix(acc, dimension) do
    range = 0..(dimension - 1)
    map = Enum.into(acc, %{}, fn {n, x, y} -> {{x, y}, n} end)

    range
    |> Enum.map(fn y ->
      for x <- range, do: Map.get(map, {x, y}, 0)
    end)
  end

  defp add(acc, dir, dimension)
  defp add([{n, _, _} | _] = acc, _dir, dim) when n >= dim * dim, do: acc

  defp add([prev | _] = acc, dir, dim) do
    next = next_point(prev, dir)

    if available(acc, next, dim) do
      add([next | acc], dir, dim)
    else
      add(acc, change_dir(dir), dim)
    end
  end

  defp next_point({n, x, y}, dir) do
    case dir do
      :right -> {n + 1, x + 1, y}
      :down -> {n + 1, x, y + 1}
      :left -> {n + 1, x - 1, y}
      :up -> {n + 1, x, y - 1}
    end
  end

  defp change_dir(:right), do: :down
  defp change_dir(:down), do: :left
  defp change_dir(:left), do: :up
  defp change_dir(:up), do: :right

  defp available(_, {_, x, _}, dim) when x < 0 or x >= dim, do: false
  defp available(_, {_, _, y}, dim) when y < 0 or y >= dim, do: false

  defp available(acc, {_, x, y}, _) do
    Enum.all?(acc, fn {_, dx, dy} -> x != dx or y != dy end)
  end
end
