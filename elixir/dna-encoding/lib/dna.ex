defmodule DNA do
  @moduledoc """
  https://exercism.org/tracks/elixir/exercises/dna-encoding
  
  In your DNA research lab, you have been working through various ways to compress your research data to save storage space
  """

  @encodings %{
    ?\s => 0b0000, 
    ?A => 0b0001, 
    ?C => 0b0010, 
    ?G => 0b0100,
    ?T => 0b1000,  
  }

  Enum.map(@encodings, fn {nucleotide, encoding} ->
    def encode_nucleotide(unquote(nucleotide)), do: unquote(encoding)
    def decode_nucleotide(unquote(encoding)), do: unquote(nucleotide)
  end)

  def encode([]), do: <<>>
  def encode([nucleotide | dna])  do
    <<encode_nucleotide(nucleotide)::4, encode(dna)::bitstring>>
  end

  def decode(<<>>), do: []
  def decode(<<nucleotide::4, rest::bitstring>>) do
    [decode_nucleotide(nucleotide) | decode(rest)]
  end
end
