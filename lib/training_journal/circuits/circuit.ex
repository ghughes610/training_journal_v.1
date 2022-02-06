defmodule TrainingJournal.Circuits.Circuit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "circuits" do


    timestamps()
  end

  @doc false
  def changeset(circuit, attrs) do
    circuit
    |> cast(attrs, [])
    |> validate_required([])
  end
end
