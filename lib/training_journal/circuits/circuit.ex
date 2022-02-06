defmodule TrainingJournal.Circuits.Circuit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "circuits" do
    field :completed, :boolean, default: false
    field :focus, :string
    field :metadata, :map, default: %{}
    field :name, :string
    field :rest_time, :string, default: "90 seconds"
    field :workout_id, :id

    timestamps()
  end

  @doc false
  def changeset(circuit, attrs) do
    circuit
    |> cast(attrs, [:name, :focus, :completed, :rest_time, :metadata])
    |> validate_required([:name, :focus, :completed, :rest_time, :metadata])
  end
end
