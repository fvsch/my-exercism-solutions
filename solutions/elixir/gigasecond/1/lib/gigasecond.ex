defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from(:calendar.datetime()) :: :calendar.datetime()
  def from(dt) do
    dt
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.add(1_000_000_000)
    |> NaiveDateTime.to_erl()
  end
end
