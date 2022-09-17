defmodule TrainingJournal.Repo.Migrations.RemoveSetsFromExercises do
  use Ecto.Migration

  def change do
    alter table(:exercises) do
      remove :sets
    end
  end
end
