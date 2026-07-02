defmodule Username do
  def sanitize(username) do
    username
    |> Enum.filter(&allowed_char(&1))
    |> Enum.map(&sanitize_char(&1))
    |> List.flatten()
  end

  defp allowed_char(char) do
    char in (Range.to_list(?a..?z) ++ ~c"_äöüß")
  end

  defp sanitize_char(char) do
    case char do
      char when char == ?ä -> ~c"ae"
      char when char == ?ö -> ~c"oe"
      char when char == ?ü -> ~c"ue"
      char when char == ?ß -> ~c"ss"
      _ -> char
    end
  end
end
