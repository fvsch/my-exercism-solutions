defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    case MapSet.member?(collection, card) do
      true -> {true, collection}
      _ -> {false, MapSet.put(collection, card)}
    end
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    can_trade = MapSet.member?(collection, your_card)
    would_trade = MapSet.member?(collection, their_card) == false

    {
      can_trade && would_trade,
      collection |> MapSet.delete(your_card) |> MapSet.put(their_card)
    }
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards)
    |> to_sorted_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    your_collection
    |> MapSet.difference(their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards([first | rest]) do
    rest
    |> Enum.reduce(first, &MapSet.intersection(&1, &2))
    |> MapSet.to_list()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0

  def total_cards([first | rest]) do
    rest
    |> Enum.reduce(first, &MapSet.union(&1, &2))
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    shiny = MapSet.filter(collection, &is_shiny/1)
    dull = MapSet.difference(collection, shiny)

    {
      to_sorted_list(shiny),
      to_sorted_list(dull)
    }
  end

  defp to_sorted_list(collection) do
    collection
    |> MapSet.to_list()
    |> Enum.sort()
  end

  defp is_shiny(card) when is_binary(card) do
    String.starts_with?(card, "Shiny ")
  end
end
