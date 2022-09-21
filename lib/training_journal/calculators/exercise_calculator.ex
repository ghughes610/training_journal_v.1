defmodule TrainingJournal.Calculators.ExerciseCalculator do

  def calculate_exercise(params) do
    data = %{
      weight: params["weight"],
      push: params["push"],
      pull: params["pull"],
      dynamic: params["dynamic"],
      isometric: params["isometric"],
      over_head: params["over_head"],
      fingers: params["fingers"],
    }

    weight_or_band = case String.match?(data.weight, ~r/^[[:alpha:]]+$/) do
      true -> "band"
      false -> heavy_or_light(String.to_integer(data.weight))
    end

IO.inspect(data)

    cond do
      data.fingers -> IO.puts("Block Pull (Over Head)")
      data.fingers && data.isometric -> IO.puts("Block Pull (Over Head) 2")
      data.fingers && data.dynamic -> "Block Pull (Row)"

      #overhead
      data.fingers && data.pull && data.dynamic && data.over_head && weight_or_band != "band" -> "Finger Curls (Over Head - 20 mm)"
      data.fingers && data.pull && data.dynamic && weight_or_band != "band" -> "Finger Curls (Over Head - 20 mm)"
      data.fingers && data.pull && data.dynamic && weight_or_band != "band" -> "Finger Curls (Row - 20 mm)"
      data.fingers && data.pull && data.over_head && weight_or_band != "band"  -> "Block Pull (Over Head)"
      data.fingers && data.pull && data.isometric && data.over_head && weight_or_band != "band" -> "Repeaters 1"

      #row
      data.fingers && data.pull && data.dynamic && weight_or_band == "heavy" -> "3 Second Hangs"
      data.fingers && data.pull && data.isometric && weight_or_band == "light" || weight_or_band == "medium" -> "Block Pull (Sitting Row)"
      data.fingers && data.over_head || weight_or_band == "light" || weight_or_band == "medium" -> "Repeaters 2"
      data.fingers && data.over_head || weight_or_band == "light" || weight_or_band == "medium" -> "Repeaters 3"
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
