defmodule Allergies do
  @allergens ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]
             |> Enum.with_index(&{&1, 2 ** &2})
             |> Map.new()

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    @allergens
    |> Map.keys()
    |> Enum.filter(&allergic_to?(flags, &1))
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) when is_map_key(@allergens, item),
    do: Bitwise.band(flags, @allergens[item]) > 0

  def allergic_to?(_flags, _item), do: false
end
