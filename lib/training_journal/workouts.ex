defmodule TrainingJournal.Workouts do
  import Ecto.Query, warn: false

  alias TrainingJournal.{
    Repo,
    Workouts.Workout
  }

  def get_workout!(id), do: Repo.get!(Workout, id)

  def list_workouts, do: Repo.all(from w in Workout, order_by: [desc: w.inserted_at])

  def list_workouts_day(day), do: Enum.filter(list_workouts(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_day(day), Timex.end_of_day(day))))

  def list_workouts_week(day), do: Enum.filter(list_workouts(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_week(day), Timex.end_of_week(day))))

  def list_workouts_month(month), do: Enum.filter(list_workouts(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_month(month), Timex.end_of_month(month))))

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
