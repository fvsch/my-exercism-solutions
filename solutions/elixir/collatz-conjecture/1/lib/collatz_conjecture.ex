defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    step(input, 0)
  end

  defp step(current, count) when is_integer(current) and is_integer(count) do
    case {current, Integer.mod(current, 2)} do
      {1, _} -> count
      {current, 0} -> step(div(current, 2), count + 1)
      {current, _} -> step(current * 3 + 1, count + 1)
    end
  end
end
