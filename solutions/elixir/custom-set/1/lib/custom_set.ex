defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}
  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable \\ []) do
    %__MODULE__{
      map: Map.new(enumerable, fn item -> {item, nil} end)
    }
  end

  @spec empty?(t) :: boolean
  def empty?(%__MODULE__{} = custom_set) do
    size(custom_set) == 0
  end

  @spec contains?(t, any) :: boolean
  def contains?(%__MODULE__{map: map}, element) do
    is_map_key(map, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(%__MODULE__{} = custom_set_1, %__MODULE__{} = custom_set_2) do
    if empty?(custom_set_1) do
      true
    else
      custom_set_1
      |> to_list()
      |> Enum.all?(&contains?(custom_set_2, &1))
    end
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%__MODULE__{} = custom_set_1, %__MODULE__{} = custom_set_2) do
    if empty?(custom_set_1) or empty?(custom_set_2) do
      true
    else
      custom_set_1
      |> to_list()
      |> Enum.all?(&(contains?(custom_set_2, &1) == false))
    end
  end

  @spec equal?(t, t) :: boolean
  def equal?(%__MODULE__{} = custom_set_1, %__MODULE__{} = custom_set_2) do
    size(custom_set_1) == size(custom_set_2) and subset?(custom_set_1, custom_set_2)
  end

  @spec add(t, any) :: t
  def add(%__MODULE__{} = custom_set, element) do
    %{custom_set | map: Map.put(custom_set.map, element, nil)}
  end

  @spec intersection(t, t) :: t
  def intersection(%__MODULE__{} = custom_set_1, %__MODULE__{} = custom_set_2) do
    [short, long] =
      [custom_set_1, custom_set_2]
      |> Enum.sort(&(size(&1) <= size(&2)))

    to_list(short)
    |> Enum.filter(&contains?(long, &1))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    to_list(custom_set_1)
    |> Enum.reject(&contains?(custom_set_2, &1))
    |> new()
  end

  @spec union(t, t) :: t
  def union(%__MODULE__{} = custom_set_1, %__MODULE__{} = custom_set_2) do
    new(to_list(custom_set_1) ++ to_list(custom_set_2))
  end

  defp size(%__MODULE__{} = custom_set) do
    map_size(custom_set.map)
  end

  defp to_list(%__MODULE__{} = custom_set) do
    Map.keys(custom_set.map)
  end
end
