defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @m 26
  @chunk_size 5

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if is_coprime?(a) do 
      encoded = 
        message 
        |> String.downcase
        |> String.to_charlist
        |> Enum.map(& encode_codepoint(&1, a, b))
        |> Enum.reject(& &1 == nil)
        |> Enum.chunk_every(@chunk_size)
        |> Enum.map(& List.to_string/1)
        |> Enum.join(" ")

      {:ok, encoded}
    else 
      {:error, "a and m must be coprime."}
    end
  end

  defp encode_codepoint(char, a, b) 
    when char >= ?a and char <= ?z do
    index = char - ?a 
    
    ((a * index) + b) 
    |> rem(@m)
    |> Kernel.+(?a)
  end
  defp encode_codepoint(char, _a, _b) 
    when char >= ?0 and char <= ?9, 
    do: char
  defp encode_codepoint(_, _, _), do: nil

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    if is_coprime?(a) do 
      mmi = inverse(a)
      decrypted = 
        encrypted
        |> String.replace(" ", "")
        |> String.to_charlist
        |> Enum.map(& decode_codepoint(&1, mmi, b))
        |> List.to_string
      {:ok, decrypted}
    else 
      {:error, "a and m must be coprime."}
    end
  end

  defp decode_codepoint(char, mmi, b) 
    when char >= ?a and char <= ?z do
    index = char - ?a 

    (mmi * (index - b))
    |> rem(@m)
    |> case do 
      x when x < 0 -> x + @m 
      x -> x 
    end
    |> Kernel.+(?a)
  end
  defp decode_codepoint(char, _, _), do: char

  defp is_coprime?(a), do: gcd(a, @m) == 1

  defp gcd(x, 0), do: x
  defp gcd(x, y), do: gcd(y, rem(x,y))
  

  defp inverse(a) do 
    Enum.reduce(1..@m, nil, & try_inverse(a, &1, &2))
  end

  defp try_inverse(a, n, nil) do 
    if rem(a * n, @m) == gcd(a, @m), 
      do: n, else: nil
  end
  defp try_inverse(_, _, i), do: i
end
