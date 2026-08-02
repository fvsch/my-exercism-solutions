defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep("", _, _), do: ""

  def grep(pattern, flags, files) do
    regex = get_regex(pattern, flags)
    reverse = "-v" in flags
    matcher = fn line -> line != "" and Regex.match?(regex, line) == !reverse end
    matches = Enum.flat_map(files, fn file -> grep_file(matcher, file) end)

    cond do
      length(matches) == 0 ->
        ""

      "-l" in flags ->
        matches |> Enum.map(fn {file, _, _} -> file end) |> Enum.uniq() |> print_lines()

      true ->
        matches |> Enum.map(fn l -> print_line(l, flags, files) end) |> print_lines()
    end
  end

  def print_line({file, n, text}, flags, files) do
    case {length(files) > 1, "-n" in flags} do
      {true, true} -> "#{file}:#{n}:#{text}"
      {true, false} -> "#{file}:#{text}"
      {false, true} -> "#{n}:#{text}"
      _ -> text
    end
  end

  def print_lines(lines) do
    Enum.join(lines, "\n") <> "\n"
  end

  def grep_file(matcher, file) do
    with {:ok, body} <- File.read(file) do
      body
      |> String.split(~r"\r?\n")
      |> Enum.with_index(1)
      |> Enum.filter(fn {line, _} -> matcher.(line) end)
      |> Enum.map(fn {line, n} -> {file, n, line} end)
    else
      _ -> []
    end
  end

  def get_regex(pattern, flags) do
    pattern
    |> Regex.escape()
    |> then(&if "-x" in flags, do: "^#{&1}$", else: &1)
    |> Regex.compile!(if "-i" in flags, do: [:caseless], else: [])
  end
end
