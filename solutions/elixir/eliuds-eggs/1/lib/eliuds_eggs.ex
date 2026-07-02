defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    number
    |> Integer.to_string(2)
    |> String.replace("0", "")
    |> String.length()
  end
end
