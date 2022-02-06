defmodule TrainingJournal.ExercisesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TrainingJournal.Exercises` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{

      })
      |> TrainingJournal.Exercises.create_exercise()

    exercise
  end
end
