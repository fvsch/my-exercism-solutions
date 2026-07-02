defmodule FreelancerRates do
  defp hours_in_day(), do: 8.0
  defp days_in_month(), do: 22.0

  def apply_discount(before_discount, discount) do
    before_discount * max(0.0, (100 - discount) / 100)
  end

  def daily_rate(hourly_rate) do
    hourly_rate * hours_in_day()
  end

  def monthly_rate(hourly_rate, discount) do
    (daily_rate(hourly_rate) * days_in_month())
    |> apply_discount(discount)
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    per_diem =
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)

    floor(budget / per_diem * 10) / 10
  end
end
