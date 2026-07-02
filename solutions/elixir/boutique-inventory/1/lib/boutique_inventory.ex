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

  def increase_quantity(item, count) do
    q = Map.new(item.quantity_by_size, fn {key, val} -> {key, val + count} end)
    %{ item | quantity_by_size: q }
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_size, num}, acc -> acc + num end)
  end
end
