defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(msg) when is_binary(msg),
      do: %StackUnderflowError{message: "stack underflow occurred, context: #{msg}"}

    def exception(_), do: %StackUnderflowError{}
  end

  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([a, b]), do: div(b, a)
  def divide(_), do: raise(StackUnderflowError, "when dividing")
end
