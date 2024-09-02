defmodule Spellcrafter.Parser do
  def parse(tokens) do
    {ast, _} = parse_spellbook(tokens)
    ast
  end

  defp parse_spellbook(tokens) do
    case tokens do
      [{:spellbook, _}, {:module, name} | rest] ->
        {spells, rest} = parse_spells(rest)
        {{:spellbook, name, spells}, rest}

      _ ->
        raise "Expected spellbook definition"
    end
  end

  defp parse_spells(tokens, acc \\ []) do
    case tokens do
      [{:scroll, _}, {:identifier, name} | rest] ->
        {body, rest} = parse_spell_body(rest)
        parse_spells(rest, acc ++ [{:scroll, name, body}])

      [{:end, _} | rest] ->
        {Enum.reverse(acc), rest}

      _ ->
        {Enum.reverse(acc), tokens}
    end
  end

  defp parse_spell_body(tokens, acc \\ []) do
    case tokens do
      [{:end, _} | rest] ->
        {Enum.reverse(acc), rest}

      [{:enchant, _}, {:identifier, var} | rest] ->
        {value, rest} = parse_value(rest)
        parse_spell_body(rest, [{:enchant, var, value} | acc])

      [{:cast, _} | rest] ->
        {call, rest} = parse_call(rest)
        parse_spell_body(rest, [call | acc])

      [token | rest] ->
        parse_spell_body(rest, [token | acc])
    end
  end

  defp parse_value([{:string, value} | rest]), do: {value, rest}
  defp parse_value([{:number, value} | rest]), do: {value, rest}
  defp parse_value([{:identifier, value} | rest]), do: {{:identifier, value}, rest}
  defp parse_value(tokens), do: parse_call(tokens)

  defp parse_call([{:module, module}, {:unknown, "." <> function} | rest]) do
    {args, rest} = parse_args(rest)
    {{:cast, module, function, args}, rest}
  end

  defp parse_call([{:unknown, module_function} | rest]) do
    [module, function] = String.split(module_function, ".")
    {args, rest} = parse_args(rest)
    {{:cast, module, function, args}, rest}
  end

  defp parse_args(tokens, acc \\ []) do
    case tokens do
      [{:identifier, arg} | rest] -> parse_args(rest, acc ++ [arg])
      _ -> {acc, tokens}
    end
  end
end
