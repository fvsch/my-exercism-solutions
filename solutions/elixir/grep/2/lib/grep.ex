defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep("", _, _), do: ""

  def grep(pattern, flags, files) do
    opts = %{
      file_name: length(files) > 1,
      line_number: "-n" in flags,
      name_only: "-l" in flags,
      reverse: "-v" in flags
    }

    regex = get_regex(pattern, flags)
    matcher = fn line -> line != "" and Regex.match?(regex, line) == !opts.reverse end

    files
    |> Enum.flat_map(&grep_file(matcher, &1))
    |> Enum.map(&print_line(&1, opts))
    |> print_lines()
  end

  defp print_line({file, n, text}, opts) do
    if opts.name_only do
      file
    else
      [
        opts.file_name && file,
        opts.line_number && n,
        text
      ]
      |> Enum.filter(&(&1 != false))
      |> Enum.join(":")
    end
  end

  defp print_lines([]), do: ""

  defp print_lines(lines) do
    lines
    |> Enum.uniq()
    |> Enum.join("\n")
    |> then(&(&1 <> "\n"))
  end

  defp grep_file(matcher, file) do
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

  defp get_regex(pattern, flags) do
    pattern
    |> Regex.escape()
    |> then(&if "-x" in flags, do: "^#{&1}$", else: &1)
    |> Regex.compile!(if "-i" in flags, do: [:caseless], else: [])
  end
end
