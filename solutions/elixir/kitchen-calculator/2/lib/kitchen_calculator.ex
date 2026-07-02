defmodule KitchenCalculator do
  def get_volume({_, num} = _), do: num

  def to_milliliter({:milliliter, num}), do: {:milliliter, num}
  def to_milliliter({:cup, num}), do: {:milliliter, 240 * num}
  def to_milliliter({:fluid_ounce, num}), do: {:milliliter, 30 * num}
  def to_milliliter({:teaspoon, num}), do: {:milliliter, 5 * num}
  def to_milliliter({:tablespoon, num}), do: {:milliliter, 15 * num}

  def from_milliliter({:milliliter, num}, :milliliter = unit), do: {unit, num}
  def from_milliliter({:milliliter, num}, :cup = unit), do: {unit, num / 240}
  def from_milliliter({:milliliter, num}, :fluid_ounce = unit), do: {unit, num / 30}
  def from_milliliter({:milliliter, num}, :teaspoon = unit), do: {unit, num / 5}
  def from_milliliter({:milliliter, num}, :tablespoon = unit), do: {unit, num / 15}

  def convert(volume, unit) do
    volume |> to_milliliter() |> from_milliliter(unit)
  end
end
