defmodule Username do
  def sanitize(username) do
    allowed = Range.to_list(?a..?z) ++ ~c"_äöüß"

    username
    |> Enum.filter(&(&1 in allowed))
    |> Enum.map(&sanitize_char(&1))
    |> List.flatten()
  end

  defp sanitize_char(char) do
    case char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> char
    end
  end
end
