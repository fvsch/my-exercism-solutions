defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=\-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d+/ui, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/\bUser\s+([[:graph:]]+)(?:\s|$)/u, line) do
      [_, name] -> "[USER] #{name} #{line}"
      _ -> line
    end
  end
end
