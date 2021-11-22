defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do     
    string 
    |> String.graphemes()
    |> Enum.reduce({0, "", ""}, &do_encode/2)
    |> compress()
  end

  defp do_encode(grapheme, {count, curr, accu} = data) do
    cond do 
      curr == "" -> {1, grapheme, accu}
      curr == grapheme -> {count + 1, curr, accu}
      true ->  {1, grapheme, compress(data)}
    end
  end

  defp compress({0, _char, accu}), do:  accu
  defp compress({1, char, accu}), do:  accu <> char
  defp compress({count, char, accu}), do: accu <> to_string(count) <> char


  @spec decode(String.t()) :: String.t()
  def decode(string) do
    {_, accu} =
      string 
      |> String.graphemes()
      |> Enum.reduce({"", ""}, &do_decode/2)

    accu
  end

  defp do_decode(grapheme, {count_string, accu}) do 
    cond do 
      # grapheme is a digit 
      String.match?(grapheme, ~r/^\d$/) -> 
        {count_string <> grapheme, accu}

      # grapheme is a singleton data 
      count_string == "" -> 
        {"", accu <> grapheme}

      # grapheme is a multiple data
      true -> 
        {count, ""} = Integer.parse(count_string) 
        {"", accu <> String.duplicate(grapheme, count)}
    end
  end

end
