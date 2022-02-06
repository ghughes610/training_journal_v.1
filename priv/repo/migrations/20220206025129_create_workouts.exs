defmodule TrainingJournal.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :name, :string
      add :date, :utc_datetime
      add :type, :string
      add :cross_training, :boolean, default: false, null: false
      add :finger_training, :boolean, default: false, null: false
      add :completed, :boolean, default: false, null: false

      timestamps()
    end
  end
end
