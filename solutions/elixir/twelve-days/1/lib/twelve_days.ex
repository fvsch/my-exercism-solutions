defmodule TwelveDays do
  @days [
    {"first", "a Partridge in a Pear Tree"},
    {"second", "two Turtle Doves"},
    {"third", "three French Hens"},
    {"fourth", "four Calling Birds"},
    {"fifth", "five Gold Rings"},
    {"sixth", "six Geese-a-Laying"},
    {"seventh", "seven Swans-a-Swimming"},
    {"eighth", "eight Maids-a-Milking"},
    {"ninth", "nine Ladies Dancing"},
    {"tenth", "ten Lords-a-Leaping"},
    {"eleventh", "eleven Pipers Piping"},
    {"twelfth", "twelve Drummers Drumming"}
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) when number in 1..12 do
    case {day_adjective(number), day_gifts(number)} do
      {nil, _} ->
        ""

      {_, []} ->
        ""

      {adj, gifts} ->
        "On the #{adj} day of Christmas my true love gave to me: #{enumerate(gifts)}."
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse//1
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)

  @spec enumerate(clauses :: list(String.t())) :: String.t()
  defp enumerate([]), do: ""
  defp enumerate([clause]), do: clause

  defp enumerate(clauses) do
    clauses
    |> List.update_at(-1, &("and " <> &1))
    |> Enum.join(", ")
  end

  defp day_adjective(number) do
    get_day_data(number, 0)
  end

  defp day_gifts(number) do
    number..1//-1
    |> Enum.map(&get_day_data(&1, 1))
    |> Enum.filter(&is_binary/1)
  end

  defp get_day_data(number, field_index) do
    get_in(@days, [Access.at(number - 1), Access.elem(field_index)])
  end
end
