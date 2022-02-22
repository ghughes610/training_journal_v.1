defmodule TrainingJournal.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :completed, :boolean, default: false
    field :cross_training, :boolean, default: false
    field :date, :utc_datetime
    field :finger_training, :boolean, default: false
    field :name, :string
    field :type, :string
    field :metadata, :map

    timestamps()
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:name, :date, :type, :cross_training, :finger_training, :completed, :metadata])
    |> validate_required([:name, :date, :type, :cross_training, :finger_training, :completed])
  end
end
