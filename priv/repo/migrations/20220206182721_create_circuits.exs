defmodule TrainingJournal.Repo.Migrations.CreateCircuits do
  use Ecto.Migration

  def change do
    create table(:circuits) do
      add :name, :string
      add :focus, :string
      add :completed, :boolean, default: false, null: false
      add :rest_time, :string, default: "90 seconds", null: "90 seconds"
      add :metadata, :map, null: false, default: %{}
      add :workout_id, references(:workouts, on_delete: :delete_all)

      timestamps()
    end

    create index(:circuits, [:workout_id])
  end
end
