defmodule TrainingJournal.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string
      add :reps, :string
      add :sets, :string
      add :weight, :string
      add :completed, :boolean, default: false, null: false
      add :rest_time, :string, default: "90 seconds", null: "90 seconds"
      add :circuit_id, references(:circuits, on_delete: :nothing), null: false
      add :metadata, :map, null: false, default: %{}

      timestamps()
    end
  end
end
