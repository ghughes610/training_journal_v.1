defmodule TrainingJournal.Repo.Migrations.UpdateExercisesTableWithCompletedSets do
  use Ecto.Migration

  def change do
    alter table(:exercises) do
    add :completed_sets, :integer, default: 0
    end
  end

  def down do
    alter table(:exercises) do
      remove :completed_sets
    end
  end

end
