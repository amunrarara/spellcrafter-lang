![Spellcrafter-Logo](https://github.com/user-attachments/assets/27ac1ecd-712d-42c0-beb4-171b18622b92)

# Spellcrafter 
## Programming is Magic

Spellcrafter is an esoteric programming language that compiles to Elixir and runs on the Erlang BEAM. It's designed to bring a touch of magic to your code!

#### This codebase was 100% created by Claude AI.

I've released it as a wonder, and an interest, for the magnificent wonder that is LLM-generated code.

## Language Concepts

- **Spellbook**: Module
- **Spell**: Function
- **Ritual**: Function
- **Incantation**: Function
- **Esoteric**: Private
- **Enchant**: Assignment
- **Rune, Sigil**: Variable
- **Secret**: Private
- **Golem/Familiar/Spirit**: Struct
- **Recipe**: Parameters
- **Ingredients**: Arguments
- **Stack**: Elixir List / Array
- **Summon**: Use/Import
- **Cast**: Instead of parentheses or dot accessor
- **Banish**: Assign to \_
- **Seal**: Defstruct
- **Conjure**: TBD
- **Open/Close**: TBD
- **Trap**: TBD
- **Begin/End**: TBD
- **Invoke**: TBD
- **Encircle**: TBD

## Sigils

Spellcrafter uses esoteric symbols called Sigils, which cause specific things to happen inside the computer. Proper use of Sigils is crucial to avoid BadMagic (exceptions and errors).

## Usage

### Using the Command-Line Interface

To run a Spellcrafter file directly from the command line:

```bash
./spellcrafter input_file.scroll
```

Make sure the `spellcrafter` script is in your PATH or run it from the project directory.

### Using the Elixir API

To compile a Spellcrafter file to Elixir:

```elixir
Spellcrafter.compile_file("input.scroll", "output.ex")
```

To run a Spellcrafter file directly:

```elixir
Spellcrafter.run_file("input.scroll")
```

## Example

Here's a simple "Hello, World!" program in Spellcrafter:

```witchcraft
spellbook Greetings
  scroll say_hello
    enchant message "Hello, magical world!"
    cast IO.puts message
  end
end

ritual main
  summon Greetings
  cast Greetings.say_hello
end
```

Save this code in a file named `hello_world.scroll`, then run it using:

```bash
./spellcrafter hello_world.scroll
```

## Development Status

This language is currently under development. Feel free to contribute and expand its magical capabilities!


## License
### Mozilla Public License 2.0
