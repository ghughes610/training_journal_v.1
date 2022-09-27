defmodule TrainingJournal.Calculators.ExerciseCalculator do
  @general_exercises [
    "Kettlebell Squat Double Bell",
    "Kettlebell SLDL",
    "Deadlift",
    "Solider Swings",
    "Side Swings",
    "Reverse Fly",
    "Chest Fly",
    "Reverse Curls",
    "Tri Extension",
    "Side Raises"
  ]

  @trx_exercises [
    "TRX Push Ups",
    "TRX Chest Fly",
    "TRX Saw",
    "TRX Tri Ext",
    "TRX Single Leg Squat",
    "TRX Rows",
    "TRX Pike Ups",
    "TRX I, Y, T"
  ]

  @heavy_finger_exercises [
    "Max Hangs for Reps",
    "Max Hangs 10:90",
    "Tension Repeaters 6:10",
    "Block Pulls 120"
  ]

  @medium_finger_exercises [
    "Hangs for Reps",
    "Repeaters 10:7",
    "Finger Curls",
    "Block Pulls 120"
  ]

  @light_finger_exercises [
    "Repeaters 10:7",
    "Finger Curls",
    "Variety Repeaters 10:7",
    "One Arm Hangs"
  ]

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

    if data.fingers == nil do
        cond do
          !is_nil(data.isometric) && !is_nil(data.pull) && !is_nil(data.over_head) -> "One Arm Pull"
          !is_nil(data.dynamic) && !is_nil(data.pull) && !is_nil(data.over_head) -> "One Arm Pull"
          !is_nil(data.push) && !is_nil(data.pull) && !is_nil(data.over_head) -> "Snatches"
          !is_nil(data.dynamic) && !is_nil(data.push) && !is_nil(data.over_head) -> "Swing Press"
          !is_nil(data.dynamic) && !is_nil(data.push) -> "Floor Chest Press"
          !is_nil(data.isometric) && !is_nil(data.push) -> "Box Squeeze Squats"
          !is_nil(data.push) && !is_nil(data.over_head) -> "Lunge Press"
          !is_nil(data.push) && !is_nil(data.pull) -> "Turkish Get Ups"
          !is_nil(data.pull) -> "Single Arm Row"
          !is_nil(data.weight) -> Enum.random(@general_exercises)
          true -> Enum.random(@trx_exercises)
        end
      else
        cond do
          !is_nil(data.dynamic) && !is_nil(data.over_head) && !is_nil(data.isometric) -> "Velocity Pull"
          !is_nil(data.isometric) && !is_nil(data.over_head) && data.weight == 0 -> "Endurance Hangs"
          !is_nil(data.isometric) && !is_nil(data.over_head) && data.weight <= 30 -> Enum.random(@light_finger_exercises)
          !is_nil(data.isometric) && !is_nil(data.over_head) && data.weight <= 50 -> Enum.random(@medium_finger_exercises)
          !is_nil(data.isometric) && !is_nil(data.over_head) && data.weight >= 70 -> Enum.random(@heavy_finger_exercises)
          !is_nil(data.over_head) && !is_nil(data.isometric) -> "2 Finger Pocket Pulls"
          !is_nil(data.isometric) -> "One Arm Row"
          !is_nil(data.dynamic) -> "One Arm Pull"
          true -> "Finger Pulls"
        end
    end

  end
end
