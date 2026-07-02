defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna), do: of_rna(rna, [])

  @spec of_rna(String.t(), [String.t()]) :: {:ok, list(String.t())} | {:error, String.t()}
  defp of_rna("", list), do: {:ok, list}
  defp of_rna(rna, _) when length(rna) < 3, do: {:error, "invalid RNA"}

  defp of_rna(rna, list) do
    case of_codon(String.slice(rna, 0..2)) do
      {:error, _} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, list}
      {:ok, protein} -> of_rna(String.slice(rna, 3..-1//1), list ++ [protein])
    end
  end

  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) when length(codon) != 3, do: {:error, "invalid codon"}

  def of_codon(codon) do
    case Map.get(@codons, codon) do
      nil -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end
