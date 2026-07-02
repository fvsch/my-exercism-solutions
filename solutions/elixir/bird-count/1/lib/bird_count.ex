defmodule BirdCount do
  def today([]), do: nil
  def today([head | _]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([today | rest]), do: [today + 1 | rest]

  def has_day_without_birds?(list) do
    Enum.any?(list, &(&1 == 0))
  end

  def total(list) do
    Enum.sum(list)
  end

  def busy_days(list) do
    list
    |> Enum.filter(&(&1 >= 5))
    |> length()
  end
end
