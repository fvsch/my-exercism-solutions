defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekdays ~w"monday tuesday wednesday thursday friday saturday sunday"a

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    day_of_week = Enum.find_index(@weekdays, &(&1 == weekday)) + 1
    first_of_month = Date.new!(year, month, 1)

    schedule_range(schedule, Date.days_in_month(first_of_month))
    |> Stream.map(&Date.new!(year, month, &1))
    |> Enum.find(fn date -> Date.day_of_week(date) == day_of_week end)
  end

  defp schedule_range(schedule, days_in_month) do
    case schedule do
      :first -> 1..7
      :second -> 8..14
      :third -> 15..21
      :fourth -> 22..28
      :teenth -> 13..19
      :last -> (days_in_month - 6)..days_in_month
    end
  end
end
