defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      length(a) > length(b) && sublist?(b, a) -> :superlist
      length(a) < length(b) && sublist?(a, b) -> :sublist
      true -> :unequal
    end
  end

  defp sublist?(_needle, [] = _haystack), do: false

  defp sublist?(needle, haystack) do
    if List.starts_with?(haystack, needle) do
      true
    else
      sublist?(needle, tl(haystack))
    end
  end
end
