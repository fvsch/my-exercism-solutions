defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score - 10, 2)
  end

  @spec ability :: pos_integer()
  def ability do
    dice_throws(4)
    |> Enum.sort()
    |> Enum.slice(1..3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    stats =
      ~w[strength dexterity constitution intelligence wisdom charisma]a
      |> Enum.map(fn key -> {key, ability()} end)
      |> Map.new()

    %DndCharacter{
      hitpoints: 10 + modifier(stats.constitution)
    }
    |> struct!(stats)
  end

  defp dice_throws(count, sides \\ 6) do
    for _n <- 1..count, do: Enum.random(1..sides)
  end
end
