defmodule GuessingGame do
  def compare(_num), do: "Make a guess"
  def compare(_num, guess) when guess == :no_guess, do: "Make a guess"
  def compare(num, guess) when guess == num, do: "Correct"
  def compare(num, guess) when guess in [num - 1, num + 1], do: "So close"
  def compare(num, guess) when guess < num, do: "Too low"
  def compare(num, guess) when guess > num, do: "Too high"
end

