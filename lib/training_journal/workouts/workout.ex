defmodule TrainingJournal.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset


  schema "workouts" do
    field :completed, :boolean, default: false
    field :cross_training, :boolean, default: false
    field :finger_training, :boolean, default: false
    field :name, :string
    field :type, :string
    field :metadata, :map

    has_many :circuits, TrainingJournal.Circuits.Circuit

    timestamps()
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:name, :type, :cross_training, :finger_training, :completed, :metadata])
    |> validate_required([:name, :type, :cross_training, :finger_training, :completed])
  end
end
