defmodule Scrabble do
  @score_map %{
    1 => "AEIOULNRST",
    2 => "DG",
    3 => "BCMP",
    4 => "FHVWY",
    5 => "K",
    8 => "JX",
    10 => "QZ"
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.trim()
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(&letter_score/1)
    |> Enum.sum()
  end

  defp letter_score(letter) do
    case Enum.find(@score_map, fn {_, letters} -> letters =~ letter end) do
      {score, _} -> score
      _ -> 0
    end
  end
end
