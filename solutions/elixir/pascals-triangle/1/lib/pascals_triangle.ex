defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    do_rows([[1]], num - 1)
    |> Enum.reverse()
  end

  defp do_rows(acc, countdown) when countdown <= 0, do: acc

  defp do_rows([prev | _] = acc, countdown) do
    next = Enum.zip_with([0 | prev], prev ++ [0], &Kernel.+/2)
    do_rows([next | acc], countdown - 1)
  end
end
