defmodule Allergies do
  @allergens ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]
  @masks Enum.with_index(@allergens, fn x, i -> {x, 2 ** i} end) |> Map.new()

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(0), do: []

  def list(flags) do
    @allergens
    |> Enum.filter(&allergic_to?(flags, &1))
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    case Map.fetch(@masks, item) do
      {:ok, mask} -> Bitwise.band(flags, mask) == mask
      _ -> false
    end
  end
end
