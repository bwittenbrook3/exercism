defmodule KitchenCalculator do
  @moduledoc """
  https://exercism.org/tracks/elixir/exercises/kitchen-calculator
  
  Converts units, milliliters as a transition unit to facilitate the conversion from any unit listed to any other.
  """

  @conversions %{
    :milliliter => 1,
    :cup => 240, 
    :fluid_ounce => 30, 
    :teaspoon => 5, 
    :tablespoon => 15
  }

  def get_volume({_unit, volume}), do: volume

  Enum.map(@conversions, fn {unit, ml_per_volume} -> 
    def to_milliliter({unquote(unit), volume}) do 
      {:milliliter, volume * unquote(ml_per_volume)}
    end
  end)

  Enum.map(@conversions, fn {unit, ml_per_volume} -> 
    def from_milliliter({:milliliter, volume}, unquote(unit)) do 
      {unquote(unit), volume / unquote(ml_per_volume)}
    end
  end)

  def convert(measurement_pair, unit) do
    measurement_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
