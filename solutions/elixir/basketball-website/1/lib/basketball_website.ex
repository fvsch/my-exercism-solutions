defmodule BasketballWebsite do
  def extract_from_path(nil, _path), do: nil

  def extract_from_path(data, path) do
    case String.split(path, ".", parts: 2) do
      [key, new_path] -> extract_from_path(data[key], new_path)
      [key] -> data[key]
    end
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
