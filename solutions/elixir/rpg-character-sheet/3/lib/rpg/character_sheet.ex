defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  defp ask(question) do
    IO.gets("#{question}\n")
    |> String.trim()
  end

  def ask_name() do
    "What is your character's name?"
    |> ask()
  end

  def ask_class() do
    "What is your character's class?"
    |> ask()
  end

  def ask_level() do
    "What is your character's level?"
    |> ask()
    |> String.to_integer()
  end

  def run() do
    welcome()

    %{
      name: ask_name(),
      class: ask_class(),
      level: ask_level()
    }
    |> IO.inspect(label: "Your character")
  end
end
