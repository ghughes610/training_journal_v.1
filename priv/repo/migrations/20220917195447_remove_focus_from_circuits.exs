defmodule TrainingJournal.Repo.Migrations.RemoveFocusFromCircuits do
  use Ecto.Migration

  def change do
    alter table(:circuits) do
      remove :focus
    end
  end

  def down do
    drop table("circuits")
  end

end
