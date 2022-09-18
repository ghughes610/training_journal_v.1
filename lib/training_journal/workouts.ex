defmodule TrainingJournal.Workouts do
  import Ecto.Query, warn: false

  alias TrainingJournal.Repo

  alias TrainingJournal.Workouts.Workout

  def list_workouts do
    query = from w in Workout, order_by: [desc: w.inserted_at]
    Repo.all(query)
  end

  def list_weeks_workouts(start_date, end_date) do
    workouts = list_workouts()
    Enum.filter(workouts, &(Timex.between?(&1.inserted_at, Timex.parse!(start_date, "{YYYY}-{0M}-{D}"), Timex.parse!(end_date, "{YYYY}-{0M}-{D}"))))
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
