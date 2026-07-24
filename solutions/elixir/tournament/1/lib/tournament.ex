defmodule Tournament do
  @table_headers ~w"Team MP W D L P"

  defmodule Score do
    defstruct team: nil, win: 0, draw: 0, loss: 0

    def new(team) do
      %__MODULE__{team: team}
    end

    def add(team, outcome) when is_binary(team) do
      add(new(team), outcome)
    end

    def add(%__MODULE__{} = s, outcome) do
      case Map.get(s, outcome) do
        n when is_integer(n) -> Map.put(s, outcome, n + 1)
        _ -> raise "team_score.#{outcome} must be an integer"
      end
    end

    def mp(%__MODULE__{} = s) do
      s.win + s.draw + s.loss
    end

    def points(%__MODULE__{} = s) do
      s.win * 3 + s.draw
    end

    def columns(%__MODULE__{} = s) do
      [s.team, mp(s), s.win, s.draw, s.loss, points(s)]
      |> Enum.map(&to_string/1)
    end

    def sort(%__MODULE__{} = s1, %__MODULE__{} = s2) do
      case {points(s1), points(s2)} do
        {p1, p2} when p1 == p2 -> s1.team <= s2.team
        {p1, p2} -> p1 > p2
      end
    end
  end

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.flat_map(&parse_line/1)
    |> Enum.reduce(%{}, &collect_result/2)
    |> print_table()
  end

  defp parse_line(str) do
    fragments = String.split(str, ";", trim: true) |> Enum.map(&String.trim/1)

    case fragments do
      [a, b, "win"] -> [{a, :win}, {b, :loss}]
      [a, b, "loss"] -> [{a, :loss}, {b, :win}]
      [a, b, "draw"] -> [{a, :draw}, {b, :draw}]
      _ -> []
    end
  end

  defp collect_result({team, outcome}, acc) when is_map_key(acc, team) do
    Map.update!(acc, team, &Score.add(&1, outcome))
  end

  defp collect_result({team, outcome}, acc) do
    Map.put_new(acc, team, Score.new(team) |> Score.add(outcome))
  end

  defp print_table(results) do
    results
    |> Map.values()
    |> Enum.sort(&Score.sort/2)
    |> Enum.map(&Score.columns/1)
    |> List.insert_at(0, @table_headers)
    |> Enum.map(&print_row/1)
    |> Enum.join("\n")
  end

  defp print_row([first | cols]) do
    first = String.pad_trailing(first, 30)
    cols = Enum.map(cols, &String.pad_leading(&1, 2))
    Enum.join([first | cols], " | ")
  end
end
