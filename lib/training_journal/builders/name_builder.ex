defmodule TrainingJournal.Builders.NameBuilder do
    
  def build_name(type) do
    type_letters = String.split(type, " ") |> Enum.map(fn str -> String.first(str) end) |> Enum.join("")
    today = Timex.format!(Timex.now(), "{M}/{D}")
    day_of_week = Timex.now |> Timex.weekday |> Timex.day_shortname

    "#{day_of_week}_#{today}_#{type_letters}"
  end

end
