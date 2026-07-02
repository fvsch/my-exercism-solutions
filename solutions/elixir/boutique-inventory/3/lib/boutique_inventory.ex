defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&(!&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(&%{&1 | name: String.replace(&1.name, old_word, new_word)})
  end

  def increase_quantity(%{quantity_by_size: sizes} = item, count) do
    inc = fn {key, val} -> {key, val + count} end
    %{item | quantity_by_size: Map.new(sizes, inc)}
  end

  def total_quantity(%{quantity_by_size: sizes}) do
    sizes
    |> Enum.reduce(0, fn {_, num}, acc -> acc + num end)
  end
end
