defmodule Spellcrafter do
  alias Spellcrafter.Lexer
  alias Spellcrafter.Parser
  alias Spellcrafter.Compiler

  def compile_file(input_file, output_file) do
    with {:ok, content} <- File.read(input_file),
         tokens <- Lexer.tokenize(content),
         ast <- Parser.parse(tokens),
         elixir_code <- Compiler.compile(ast) do
      File.write(output_file, elixir_code)
    else
      error -> {:error, error}
    end
  end

  def run_file(input_file) do
    IO.puts("Starting run_file for: #{input_file}")
    with {:ok, content} <- File.read(input_file),
         _ <- IO.inspect(content, label: "File content"),
         tokens <- Lexer.tokenize(content),
         _ <- IO.inspect(tokens, label: "Tokens"),
         ast <- Parser.parse(tokens),
         _ <- IO.inspect(ast, label: "AST"),
         elixir_code <- Compiler.compile(ast) do
      IO.puts("Compilation successful. Generated Elixir code:")
      IO.puts(elixir_code)
      [{module, _}] = Code.compile_string(elixir_code)
      apply(module, :main, [])
    else
      error -> 
        IO.puts("Error occurred:")
        IO.inspect(error)
        {:error, error}
    end
  end

  def main(args) do
    IO.puts("Starting Spellcrafter with args: #{inspect(args)}")
    case args do
      [input_file] ->
        case Path.extname(input_file) do
          ".scroll" ->
            IO.puts("Processing .scroll file: #{input_file}")
            case run_file(input_file) do
              :ok -> IO.puts("Spell cast successfully!")
              {:error, error} -> IO.puts("BadMagic occurred: #{inspect(error)}")
            end
          _ ->
            IO.puts("Error: Input file must have a .scroll extension")
        end
      _ ->
        IO.puts("Usage: spellcrafter <input_file.scroll>")
    end
  end
end