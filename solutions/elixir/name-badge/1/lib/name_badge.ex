defmodule NameBadge do
  def print(id, name, department) do
    [
      if(id, do: "[#{id}]", else: nil),
      name,
      if(department, do: department, else: "owner") |> String.upcase()
    ]
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.join(" - ")
  end
end
