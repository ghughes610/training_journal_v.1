defmodule TrainingJournal.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :name, :string
    field :reps, :integer
    field :weight, :integer
    field :metadata, :map, default: %{}
    field :circuit_id, :id
    field :push, :boolean, default: true
    field :pull, :boolean, default: false
    field :dynamic, :boolean, default: false
    field :isometric, :boolean, default: false
    field :over_head, :boolean, default: true
    field :fingers, :boolean, default: false

    timestamps()
  end

  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :reps, :weight, :metadata, :circuit_id, :push, :pull, :dynamic, :isometric, :over_head, :fingers])
    |> validate_required([:name, :reps, :weight, :metadata, :circuit_id, :push, :pull, :dynamic, :isometric, :over_head, :fingers])
  end
end
