defmodule Bob do
  def hey(input) do
    cond do
      Regex.match?(~r/\A( )*\Z/, input) -> "Fine. Be that way!"
      Regex.match?(~r/\?\Z/, input) -> "Sure."
      Regex.match?(~r/.*\p{Ll}.*/, input) -> "Whatever."
      Regex.match?(~r/.*(\p{Lu}).*/, input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
