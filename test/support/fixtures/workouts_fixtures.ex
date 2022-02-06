defmodule TrainingJournal.WorkoutsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TrainingJournal.Workouts` context.
  """

  @doc """
  Generate a workout.
  """
  def workout_fixture(attrs \\ %{}) do
    {:ok, workout} =
      attrs
      |> Enum.into(%{
        completed: true,
        cross_training: true,
        date: ~U[2022-02-05 02:51:00Z],
        finger_training: true,
        name: "some name",
        type: "some type"
      })
      |> TrainingJournal.Workouts.create_workout()

    workout
  end
end
