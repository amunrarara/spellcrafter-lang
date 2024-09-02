defmodule Spellcrafter.Lexer do
  def tokenize(code) do
    code
    |> String.replace("\n", " ")
    |> tokenize_string([])
    |> Enum.reverse()
  end

  defp tokenize_string("", acc), do: acc

  defp tokenize_string("\"" <> rest, acc) do
    {string, rest} = extract_string(rest)
    tokenize_string(rest, [{:string, "\"#{string}\""} | acc])
  end

  defp tokenize_string(code, acc) do
    case String.split(code, " ", parts: 2) do
      [word, rest] -> tokenize_string(rest, [tokenize_word(word) | acc])
      [word] -> [tokenize_word(word) | acc]
    end
  end

  defp extract_string(code), do: extract_string(code, "")

  defp extract_string("\"" <> rest, acc), do: {acc, rest}
  defp extract_string("\\" <> "\"" <> rest, acc), do: extract_string(rest, acc <> "\\\"")
  defp extract_string(<<c::utf8, rest::binary>>, acc), do: extract_string(rest, acc <> <<c::utf8>>)

  defp tokenize_word("spellbook"), do: {:spellbook, "spellbook"}
  defp tokenize_word("scroll"), do: {:scroll, "scroll"}
  defp tokenize_word("ritual"), do: {:ritual, "ritual"}
  defp tokenize_word("incantation"), do: {:incantation, "incantation"}
  defp tokenize_word("esoteric"), do: {:esoteric, "esoteric"}
  defp tokenize_word("enchant"), do: {:enchant, "enchant"}
  defp tokenize_word("rune"), do: {:rune, "rune"}
  defp tokenize_word("sigil"), do: {:sigil, "sigil"}
  defp tokenize_word("secret"), do: {:secret, "secret"}
  defp tokenize_word("golem"), do: {:golem, "golem"}
  defp tokenize_word("familiar"), do: {:familiar, "familiar"}
  defp tokenize_word("spirit"), do: {:spirit, "spirit"}
  defp tokenize_word("recipe"), do: {:recipe, "recipe"}
  defp tokenize_word("ingredients"), do: {:ingredients, "ingredients"}
  defp tokenize_word("stack"), do: {:stack, "stack"}
  defp tokenize_word("summon"), do: {:summon, "summon"}
  defp tokenize_word("cast"), do: {:cast, "cast"}
  defp tokenize_word("banish"), do: {:banish, "banish"}
  defp tokenize_word("seal"), do: {:seal, "seal"}
  defp tokenize_word("end"), do: {:end, "end"}

  defp tokenize_word(word) do
    cond do
      String.match?(word, ~r/^[A-Z][a-zA-Z0-9]*$/) -> {:module, word}
      String.match?(word, ~r/^[a-z_][a-zA-Z0-9_]*$/) -> {:identifier, word}
      String.match?(word, ~r/^[0-9]+$/) -> {:number, word}
      true -> {:unknown, word}
    end
  end
end
