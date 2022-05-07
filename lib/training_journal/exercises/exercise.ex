defmodule TrainingJournal.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :name, :string
    field :sets, :integer
    field :reps, :integer
    field :weight, :string
    field :metadata, :map, default: %{}
    field :circuit_id, :id

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :sets, :reps, :weight, :metadata, :circuit_id])
    |> validate_required([:name, :sets, :reps, :weight, :metadata, :circuit_id])
  end
end
