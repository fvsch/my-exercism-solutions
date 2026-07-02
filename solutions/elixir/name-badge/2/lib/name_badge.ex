defmodule NameBadge do
  def print(id, name, department) do
    [
      if(id, do: "[#{id}]", else: nil),
      name,
      if(department, do: String.upcase(department), else: "OWNER")
    ]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(" - ")
  end
end
