defmodule TrainingJournal.Repo.Migrations.AddNumberOfExercisesToCircuits do
  use Ecto.Migration

  def change do
    alter table(:circuits) do
      add :number_of_exercises, :integer, default: 3
    end
  end
end
