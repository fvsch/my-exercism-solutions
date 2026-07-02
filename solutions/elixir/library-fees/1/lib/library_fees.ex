defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(%NaiveDateTime{} = datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T"12:00:00") == :lt
  end

  def return_date(%NaiveDateTime{} = checkout) do
    checkout
    |> NaiveDateTime.to_date()
    |> Date.add(if before_noon?(checkout), do: 28, else: 29)
  end

  def days_late(%Date{} = expected, %NaiveDateTime{} = actual) do
    days =
      actual
      |> NaiveDateTime.to_date()
      |> Date.diff(expected)

    Enum.max([0, days])
  end

  def monday?(%NaiveDateTime{} = datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)
    days = checkout |> return_date() |> days_late(return)

    if monday?(return) do
      Float.floor(rate * 0.5 * days)
    else
      rate * days
    end
  end
end
