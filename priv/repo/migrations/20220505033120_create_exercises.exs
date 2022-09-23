defmodule TrainingJournal.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
        add :name, :string
        add :sets, :integer
        add :reps, :integer
        add :weight, :integer
        add :metadata, :map, null: false, default: %{}
        add :circuit_id, references(:circuits, on_delete: :delete_all)

      timestamps()
    end
    create index(:exercises, [:circuit_id])
  end

  def down do
    remove :circuit_id
  end
end
