defmodule Secrets do
  def secret_add(secret) do
    &(&1 + secret)
  end

  def secret_subtract(secret) do
    &(&1 - secret)
  end

  def secret_multiply(secret) do
    &(&1 * secret)
  end

  def secret_divide(secret) do
    &(div &1, secret)
  end

  def secret_and(secret) do
    &(Bitwise.band secret, &1)
  end

  def secret_xor(secret) do
    &(Bitwise.bxor secret, &1)
  end

  def secret_combine(fn1, fn2) do
    &(fn2.(fn1.(&1)))
  end
end
