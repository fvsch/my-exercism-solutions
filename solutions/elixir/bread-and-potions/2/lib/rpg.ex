defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(term, char)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_loaf, %Character{health: health} = char) do
      {
        nil,
        %{char | health: health + 5}
      }
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(potion, %Character{mana: mana} = char) do
      {
        %EmptyBottle{},
        %{char | mana: mana + potion.strength}
      }
    end
  end

  defimpl Edible, for: Poison do
    def eat(_poison, %Character{} = char) do
      {
        %EmptyBottle{},
        %{char | health: 0}
      }
    end
  end
end
