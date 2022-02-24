defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) when is_binary(word) do
    word 
    |> String.graphemes()
    |> Enum.reduce(0, fn letter, accu -> 
      score = 
        letter 
        |> String.downcase()
        |> score_letter()
      
      accu + score 
    end)
  end


  defp score_letter(letter) do 
    cond do 
      Enum.member?(~w(a e i o u l n r s t), letter) -> 1
      Enum.member?(~w(d g), letter) -> 2
      Enum.member?(~w(b c m p), letter) -> 3
      Enum.member?(~w(f h v w y), letter) -> 4
      Enum.member?(~w(k), letter) -> 5
      Enum.member?(~w(j x), letter) -> 8
      Enum.member?(~w(q z), letter) -> 10
      true -> 0
    end 
  end 

end
