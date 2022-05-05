defmodule TrainingJournal.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do


    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [])
    |> validate_required([])
  end
end
