defmodule Lasagna do
  def expected_minutes_in_oven() do
    40
  end

  def remaining_minutes_in_oven(ellapsed) do
    max(0, expected_minutes_in_oven() - ellapsed)
  end

  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  def total_time_in_minutes(layers, ellapsed) do
    preparation_time_in_minutes(layers) + ellapsed
  end

  def alarm() do
    "Ding!"
  end
end
