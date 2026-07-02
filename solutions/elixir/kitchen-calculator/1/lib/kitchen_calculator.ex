defmodule KitchenCalculator do
  def get_volume({_, num} = _), do: num

  def to_milliliter({:milliliter, num} = _), do: {:milliliter, num}
  def to_milliliter({:cup, num} = _), do: {:milliliter, 240 * num}
  def to_milliliter({:fluid_ounce, num} = _), do: {:milliliter, 30 * num}
  def to_milliliter({:teaspoon, num} = _), do: {:milliliter, 5 * num}
  def to_milliliter({:tablespoon, num} = _), do: {:milliliter, 15 * num}

  def from_milliliter({:milliliter, num} = _, :milliliter = unit), do: {unit, num}
  def from_milliliter({:milliliter, num} = _, :cup = unit), do: {unit, num / 240}
  def from_milliliter({:milliliter, num} = _, :fluid_ounce = unit), do: {unit, num / 30}
  def from_milliliter({:milliliter, num} = _, :teaspoon = unit), do: {unit, num / 5}
  def from_milliliter({:milliliter, num} = _, :tablespoon = unit), do: {unit, num / 15}

  def convert(volume, unit) do
    volume |> to_milliliter() |> from_milliliter(unit)
  end
end
