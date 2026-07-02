defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&is_nil(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item.name, old_word, new_word)}
    end)
  end

  def increase_quantity(%{quantity_by_size: sizes} = item, count) do
    sizes = Map.new(sizes, fn {key, val} -> {key, val + count} end)
    %{item | quantity_by_size: sizes}
  end

  def total_quantity(%{quantity_by_size: sizes}) do
    sizes
    |> Map.values()
    |> Enum.sum()
  end
end
