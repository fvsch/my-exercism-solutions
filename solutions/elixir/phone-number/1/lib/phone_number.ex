defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    with {:ok, digits} <- digits_only(raw),
         {:ok, ten_digits} <- constrain_length(digits),
         {:ok, valid_number} <- check_codes(ten_digits) do
      {:ok, valid_number}
    end
  end

  defp digits_only(str) do
    if String.match?(String.trim(str), ~r{^\+?[\d()-. ]+$}) do
      {:ok, String.replace(str, ~r"\D", "")}
    else
      {:error, "must contain digits only"}
    end
  end

  defp constrain_length(digits) do
    case String.length(digits) do
      10 ->
        {:ok, digits}

      11 ->
        if String.first(digits) == "1",
          do: {:ok, String.slice(digits, 1, 10)},
          else: {:error, "11 digits must start with 1"}

      len when len < 10 ->
        {:error, "must not be fewer than 10 digits"}

      _ ->
        {:error, "must not be greater than 11 digits"}
    end
  end

  defp check_codes(digits) do
    case {String.at(digits, 0), String.at(digits, 3)} do
      {"0", _} -> {:error, "area code cannot start with zero"}
      {"1", _} -> {:error, "area code cannot start with one"}
      {_, "0"} -> {:error, "exchange code cannot start with zero"}
      {_, "1"} -> {:error, "exchange code cannot start with one"}
      _ -> {:ok, digits}
    end
  end
end
