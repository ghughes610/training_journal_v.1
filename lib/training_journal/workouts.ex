defmodule TrainingJournal.Workouts do
  @moduledoc """
  The Workouts context.
  """

  import Ecto.Query, warn: false
  alias TrainingJournal.Repo

  alias TrainingJournal.Workouts.Workout

  def list_workouts do
    query = from w in Workout, order_by: [desc: w.inserted_at]
    Repo.all(query)
  end

  def get_workout!(id), do: Repo.get!(Workout, id)

  def create_workout(attrs \\ %{}) do
    %Workout{}
    |> Workout.changeset(attrs)
    |> Repo.insert()
  end

  def update_workout(%Workout{} = workout, attrs) do
    workout
    |> Workout.changeset(attrs)
    |> Repo.update()
  end

  def delete_workout(%Workout{} = workout) do
    Repo.delete(workout)
  end

  def change_workout(%Workout{} = workout, attrs \\ %{}) do
    Workout.changeset(workout, attrs)
  end

end
