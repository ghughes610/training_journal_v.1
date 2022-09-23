defmodule TrainingJournal.Repo.Migrations.RemoveDateFromWorkouts do
  use Ecto.Migration

  def change do
    alter table(:workouts) do
      remove :date
    end
  end

  def down do
    drop table("workouts")
  end

end
