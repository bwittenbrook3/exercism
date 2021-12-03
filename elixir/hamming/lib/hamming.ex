defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    do_hamming(strand1, strand2, {:ok, 0})
  end

  defp do_hamming([h1 | tail1], [h2 | tail2], {:ok, count}) do
    count =
      if h1 === h2 do
        count
      else
        count + 1
      end

    do_hamming(tail1, tail2, {:ok, count})
  end

  defp do_hamming([], [], {:ok, cnt}), do: {:ok, cnt}
  defp do_hamming(_, _, _), do: {:error, "strands must be of equal length"}
end
