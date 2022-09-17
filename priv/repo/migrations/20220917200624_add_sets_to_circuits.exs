defmodule TrainingJournal.Repo.Migrations.AddSetsToCircuits do
  use Ecto.Migration

  def change do
    alter table(:circuits) do
      add :sets, :integer, default: 3
    end
  end
end
