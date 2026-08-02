defmodule BafflingBirthdays do
  @moduledoc """
  Estimate the probability of shared birthdays in a group of people.
  """

  @spec shared_birthday?(birthdates :: [Date.t()]) :: boolean()
  def shared_birthday?([]), do: false

  def shared_birthday?(bdates) do
    bdates
    |> Enum.reduce_while(MapSet.new(), &uniq_bday/2)
    |> MapSet.size()
    |> then(&(&1 < length(bdates)))
  end

  @spec random_birthdates(group_size :: integer()) :: [Date.t()]
  def random_birthdates(group_size) when group_size > 0 do
    for _ <- 1..group_size, do: random_birthdate()
  end

  @spec estimated_probability_of_shared_birthday(group_size :: integer()) :: float()
  def estimated_probability_of_shared_birthday(group_size) when group_size < 2, do: 0.0

  def estimated_probability_of_shared_birthday(group_size) do
    sample_size = if(group_size > 500, do: 200, else: 600)
    shared_count = sample(group_size, sample_size, 0)
    100 * shared_count / sample_size
  end

  defp random_birthdate() do
    Enum.random(1901..2025//2)
    |> Date.new!(1, 1)
    |> Date.add(Enum.random(0..364))
  end

  defp sample(_, samples, count) when samples < 1, do: count

  defp sample(group_size, samples, count) do
    group_size
    |> random_birthdates()
    |> shared_birthday?()
    |> if(do: count + 1, else: count)
    |> then(&sample(group_size, samples - 1, &1))
  end

  defp uniq_bday(%Date{month: month, day: day}, %MapSet{} = bdays) do
    if MapSet.member?(bdays, {month, day}) do
      {:halt, bdays}
    else
      {:cont, MapSet.put(bdays, {month, day})}
    end
  end
end
