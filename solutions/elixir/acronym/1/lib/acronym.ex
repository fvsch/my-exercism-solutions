defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.upcase()
    |> String.replace("-", " ")
    |> String.replace(~r/[^\sA-Z]/u, "")
    |> String.split(~r"\s", trim: true)
    |> Enum.reduce("", fn s, acc -> acc <> String.first(s) end)
  end
end
