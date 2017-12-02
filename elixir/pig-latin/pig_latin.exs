defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map_join(" ", &(translate_word(&1)))
  end

  defp translate_word(word) do
    [starts_with_vowel, consonants] = rearrange_to_start_with_vowel(word)
    starts_with_vowel <> consonants <> "ay"
  end

  @vowel_groups_regex ~r/\A([aeiou]|yt|xr)/
  @consonants_groups_regex ~r/\A(qu|ch|squ|thr|th|sch)/
  defp rearrange_to_start_with_vowel(""), do: ["", ""]
  defp rearrange_to_start_with_vowel(phrase) do
    cond do
      Regex.match?(@vowel_groups_regex, phrase) -> [phrase, ""]
      Regex.match?(@consonants_groups_regex, phrase) ->
        Regex.split( @consonants_groups_regex,
                     phrase,
                     include_captures: true,
                     trim: true                )
        |> Enum.reverse
      true ->
        <<head::binary-size(1), rest::binary>> = phrase
        [ starts_with_vowel, consonants] = rearrange_to_start_with_vowel(rest)
        [ starts_with_vowel, head <> consonants]
    end
  end



end
