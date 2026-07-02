defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name |> String.trim() |> String.first()
  end

  def initial(name) do
    "#{first_letter(name)}." |> String.upcase()
  end

  def initials(full_name) do
    full_name
    |> String.split()
    |> Enum.filter(fn s -> String.trim(s) != "" end)
    |> Enum.map_join(" ", fn s -> initial(s) end)
  end

  def pair(full_name1, full_name2) do
    text = "#{initials(full_name1)}  +  #{initials(full_name2)}"
    padded = "  #{text}  "
    line = String.duplicate("-", String.length(padded))

    """
    ❤#{line}❤
    |#{padded}|
    ❤#{line}❤
    """
  end
end
