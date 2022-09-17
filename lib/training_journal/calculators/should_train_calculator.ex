defmodule TrainingJournal.Calculators.ShouldTrainCalculator do
  def should_train(freshness, days_on) do
    freshness = String.to_integer(freshness)
    days_on = String.to_integer(days_on)

      cond do
        freshness >= 8 && days_on <= 2 -> "Yes"
        freshness <= 7 && freshness >= 6 && days_on <= 3 -> "Maybe - #{days_on} days on"
        freshness <= 5|| days_on > 3 -> "No"
      end
  end

end
