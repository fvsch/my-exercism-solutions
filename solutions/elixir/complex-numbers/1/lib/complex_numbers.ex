defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({r, _}), do: r

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_, i}), do: i

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, b) do
    {r1, i1} = to_complex(a)
    {r2, i2} = to_complex(b)

    {
      r1 * r2 - i1 * i2,
      r1 * i2 + r2 * i1
    }
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) do
    {r1, i1} = to_complex(a)
    {r2, i2} = to_complex(b)

    {
      r1 + r2,
      i1 + i2
    }
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) do
    {r1, i1} = to_complex(a)
    {r2, i2} = to_complex(b)
    {r1 - r2, i1 - i2}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) do
    {r1, i1} = to_complex(a)
    {r2, i2} = to_complex(b)
    divisor = r2 ** 2 + i2 ** 2

    {
      (r1 * r2 + i1 * i2) / divisor,
      (r2 * i1 - r1 * i2) / divisor
    }
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({r, i}) do
    :math.sqrt(r ** 2 + i ** 2)
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({r, i}) do
    {r, -1 * i}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({r, i}) do
    mul(
      {:math.exp(r), 0},
      {:math.cos(i), :math.sin(i)}
    )
  end

  defp to_complex(a) when is_number(a), do: {a, 0}
  defp to_complex({r, i}) when is_number(r) and is_number(i), do: {r, i}
end
