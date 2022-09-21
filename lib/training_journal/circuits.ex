defmodule TrainingJournal.Circuits do
  import Ecto.Query, warn: false

  alias TrainingJournal.{
    Circuits.Circuit,
    Repo
  }

  def get_circuit!(id), do: Repo.get!(Circuit, id)

  def list_circuits, do: Repo.all(from c in Circuit, order_by: [desc: c.inserted_at])

  def list_circuits_day(day), do: Enum.filter(list_circuits(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_day(day), Timex.end_of_day(day))))

  def list_circuits_week(day), do: Enum.filter(list_circuits(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_week(day), Timex.end_of_week(day))))

  def list_circuits_month(month), do: Enum.filter(list_circuits(), &(Timex.between?(&1.inserted_at, Timex.beginning_of_month(month), Timex.end_of_month(month))))

  def get_workout_circuits(workout_id) do
      list_circuits()
      |> Enum.filter(&(&1.workout_id == workout_id))
  end

  def create_circuit(attrs \\ %{}) do
    %Circuit{}
    |> Circuit.changeset(attrs)
    |> Repo.insert()
  end

  def update_circuit(%Circuit{} = circuit, attrs) do
    circuit
    |> Circuit.changeset(attrs)
    |> Repo.update()
  end

  def delete_circuit(%Circuit{} = circuit) do
    Repo.delete(circuit)
  end

  def change_circuit(%Circuit{} = circuit, attrs \\ %{}) do
    Circuit.changeset(circuit, attrs)
  end
end
