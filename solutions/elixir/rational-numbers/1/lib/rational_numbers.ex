defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(r1 :: rational, r2 :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    {a1 * b2 + a2 * b1, b1 * b2} |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(r1 :: rational, r2 :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    {a1 * b2 - a2 * b1, b1 * b2} |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(r1 :: rational, r2 :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    {a1 * a2, b1 * b2} |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(r1 :: rational, r2 :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) when a2 != 0 do
    {a1 * b2, a2 * b1} |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs({a, b}) do
    {Kernel.abs(a), Kernel.abs(b)} |> reduce()
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(r :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) do
    if n < 0 do
      m = Kernel.abs(n)
      {Integer.pow(b, m), Integer.pow(a, m)} |> reduce()
    else
      {Integer.pow(a, n), Integer.pow(b, n)} |> reduce()
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    Float.pow(x * 1.0, a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce({a, b}) do
    sign = if(b < 0, do: -1, else: 1)
    divisor = Integer.gcd(a, b)

    cond do
      divisor > 1 -> {div(a * sign, divisor), div(b * sign, divisor)}
      true -> {a * sign, b * sign}
    end
  end
end
