defmodule TrainingJournal.Exercises do
  import Ecto.Query, warn: false
  
  alias TrainingJournal.{
    Exercises.Exercise,
    Repo
  }

  def get_exercise!(id), do: Repo.get!(Exercise, id)

  def list_exercises, do: Repo.all(from e in Exercise, order_by: [desc: e.inserted_at])

  def list_exercises_day(day), do: Enum.filter(list_exercises(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_day(day), Timex.end_of_day(day))))

  def list_exercises_week(day), do: Enum.filter(list_exercises(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_week(day), Timex.end_of_week(day))))

  def list_exercises_month(month), do: Enum.filter(list_exercises(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_month(month), Timex.end_of_month(month))))

  def get_circuit_exercises(circuit_id) do
      list_exercises()
      |> Enum.filter(&(&1.circuit_id == circuit_id))
  end

  def create_exercise(attrs \\ %{}) do
    %Exercise{}
    |> Exercise.changeset(attrs)
    |> Repo.insert()
  end

  def update_exercise(%Exercise{} = exercise, attrs) do
    exercise
    |> Exercise.changeset(attrs)
    |> Repo.update()
  end

  def delete_exercise(%Exercise{} = exercise) do
    Repo.delete(exercise)
  end

  def change_exercise(%Exercise{} = exercise, attrs \\ %{}) do
    Exercise.changeset(exercise, attrs)
  end
end
