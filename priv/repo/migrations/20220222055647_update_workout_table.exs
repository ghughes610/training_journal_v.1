defmodule TrainingJournal.Repo.Migrations.UpdateWorkoutTable do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      add :metadata, :map, default: %{}
    end
  end
end
