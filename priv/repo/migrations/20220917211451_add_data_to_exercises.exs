defmodule TrainingJournal.Repo.Migrations.AddDataToExercises do
  use Ecto.Migration

  def change do
    alter table(:exercises) do
      add :push, :boolean, default: true
      add :pull, :boolean, default: false
      add :dynamic, :boolean, default: false
      add :isometric, :boolean, default: false
      add :over_head, :boolean
      add :fingers, :boolean
    end
  end

  def down do
    drop table("exercises")
  end
end
