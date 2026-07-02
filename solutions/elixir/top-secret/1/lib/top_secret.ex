defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    case List.first(args) do
      {:when, _, [{_, _, _} = header | _]} -> {ast, [fn_slice(header) | acc]}
      {_, _, _} = header -> {ast, [fn_slice(header) | acc]}
      _ -> {ast, acc}
    end
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    {_, acc} =
      Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2        
      )

    acc
    |> Enum.reverse()
    |> Enum.join()
  end

  defp fn_slice({_name, _, nil}), do: ""
  defp fn_slice({name, _, args}), do: String.slice(to_string(name), 0, length(args))
end
