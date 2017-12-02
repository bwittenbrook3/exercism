defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    {day, _} = gift_for_day(number)
    gifts = gifts_for_day(number)
    "On the #{day} day of Christmas my true love gave to me, #{to_sentence(gifts)}."
  end

  defp to_sentence([head]), do: head
  defp to_sentence([head, tail]) do
    cond do
      length(tail) == 1 ->
        "#{head}, and #{tail}"
      true ->
        "#{head}, #{to_sentence(tail)}"
    end
  end

  defp gift_for_day(1), do: {"first", "a Partridge in a Pear Tree"}
  defp gift_for_day(2), do: {"second", "two Turtle Doves"}
  defp gift_for_day(3), do: {"third", "three French Hens"}
  defp gift_for_day(4), do: {"fourth", "four Calling Birds"}
  defp gift_for_day(5), do: {"fifth", "five Gold Rings"}
  defp gift_for_day(6), do: {"sixth", "six Geese-a-Laying"}
  defp gift_for_day(7), do: {"seventh", "seven Swans-a-Swimming"}
  defp gift_for_day(8), do: {"eighth", "eight Maids-a-Milking"}
  defp gift_for_day(9), do: {"ninth", "nine Ladies Dancing"}
  defp gift_for_day(10), do: {"tenth", "ten Lords-a-Leaping"}
  defp gift_for_day(11), do: {"eleventh", "eleven Pipers Piping"}
  defp gift_for_day(12), do: {"twelfth", "twelve Drummers Drumming"}


  defp gifts_for_day(index) when index > 0 do
    cond do
      index == 1 ->
        {_, gift} = gift_for_day(1)
        [gift]
      true ->
        {_, gift} = gift_for_day(index)
        [gift, gifts_for_day(index - 1)]
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map_join "\n", fn(index) -> verse(index) end
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1,12)
  end
end
