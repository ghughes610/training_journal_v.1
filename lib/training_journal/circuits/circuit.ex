defmodule TrainingJournal.Circuits.Circuit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "circuits" do
    field :completed, :boolean, default: false
    field :number_of_exercises, :integer, default: 3
    field :metadata, :map, default: %{}
    field :name, :string
    field :rest_time, :string, default: "2 minutes"
    field :sets, :integer, default: 3

    belongs_to :workout, TrainingJournal.Workouts.Workout
    has_many :exercise,  TrainingJournal.Exercises.Exercise


    timestamps()
  end

  @doc false
  def changeset(circuit, attrs) do
    circuit
    |> cast(attrs, [:name, :number_of_exercises, :completed, :rest_time, :metadata, :workout_id, :sets])
    |> validate_required([:name, :number_of_exercises, :completed, :rest_time, :metadata, :sets])
  end
end
