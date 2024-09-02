defmodule Spellcrafter.Compiler do
  def compile(ast) do
    IO.puts("Full AST:")
    IO.inspect(ast, limit: :infinity)
    case ast do
      {:spellbook, name, spells} ->
        """
        defmodule #{name} do
        #{Enum.map_join(spells, "\n", &compile_spell/1)}
        end
        """

      _ ->
        raise "Unexpected AST node"
    end
  end

  defp compile_spell({:scroll, name, body}) do
    IO.puts("Compiling scroll: #{name}")
    IO.inspect(body, label: "Scroll body")
    """
      def #{name} do
        #{compile_body(body)}
      end
    """
  end

  defp compile_body(body) do
    chunks = body
    |> Enum.chunk_by(fn
      {:enchant, "enchant"} -> :enchant
      _ -> :other
    end)
    IO.puts("Chunked body:")
    IO.inspect(chunks, limit: :infinity)
    chunks
    |> Enum.map(&compile_chunk/1)
    |> Enum.join("\n")
  end

  defp compile_chunk([{:enchant, "enchant"}, var, value]) do
    IO.puts("Compiling enchant:")
    IO.inspect([{:enchant, "enchant"}, var, value])
    "#{compile_expression(var)} = #{compile_expression(value)}"
  end

  defp compile_chunk(chunk) do
    IO.puts("Compiling chunk:")
    IO.inspect(chunk)
    chunk
    |> Enum.map(&compile_expression/1)
    |> Enum.join("\n")
  end

  defp compile_expression({:cast, module, function, args}) do
    args_str = Enum.map_join(args, ", ", &compile_expression/1)
    "#{compile_expression(module)}.#{compile_expression(function)}(#{args_str})"
  end

  defp compile_expression({:identifier, name}), do: name
  defp compile_expression({:string, value}), do: value
  defp compile_expression({:number, value}), do: value
  defp compile_expression({:module, name}), do: name
  defp compile_expression({token_type, value}) when is_atom(token_type), do: value

  defp compile_expression(token) do
    IO.puts("Unexpected token:")
    IO.inspect(token)
    raise "Unexpected token: #{inspect(token)}"
  end
end
