defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(<<head::utf8, rest::binary>>, shift) do
    <<shift_letter(head, shift)::utf8, rotate(rest, shift)::binary>>
  end
  def rotate("", _), do: ""


  defp shift_letter(letter, shift) when letter in ?a..?z do
    ?a + rem(letter - ?a + shift, 26)
  end
  defp shift_letter(letter, shift) when letter in ?A..?Z  do
    ?A + rem(letter - ?A + shift, 26)
  end
  defp shift_letter(letter, _), do: letter


end
