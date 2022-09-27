defmodule TrainingJournal.Calculators.WeightCalculator do


  def weight_or_band(weight) do
    case String.match?(weight, ~r/^[[:alpha:]]+$/) do
      true -> "band"
      false -> heavy_or_light(String.to_integer(weight))
    end
  end

  def heavy_or_light(lb) do
    cond do
      lb >= 1 && lb <= 30 -> "light"
      lb >= 31 && lb <= 50 -> "medium"
      lb >= 51 && lb <= 70 -> "heavy"
      true -> "extra heavy"
    end
  end

end
