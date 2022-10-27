defmodule TrainingJournalWeb.CircuitLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Builders.NameBuilder,
    Circuits,
    Workouts
  }

  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)
    full_workout = Workouts.get_full_workout(id)
    socket = assign(socket, circuits: full_workout.circuit, id: id)

    {:ok, socket}
  end

    def handle_event("delete", %{"id" => id}, socket) do
    circuits = get_circuits(socket)
    circuit = Circuits.get_circuit!(id)

    with {:ok, deleted_circuit} <- Circuits.delete_circuit(circuit) do
      circuits = Enum.filter(circuits, fn circuit -> circuit.id != deleted_circuit.id end)

      {:noreply, assign(socket, :circuits, circuits)}
    end
  end

  def handle_event("create_circuit", params, socket) do
    name = if params["circuit_number"] == "" do
      NameBuilder.build_name(params["circuit_number"])
    else
      params["circuit_number"]
    end
    data = %{
      name: name,
      completed: false,
      number_of_exercises: String.to_integer(params["number_of_exercises"]),
      sets: String.to_integer(params["sets"]),
      rest_time: params["rest_time"],
      workout_id: socket.assigns.id,
      metadata: %{},
      circuit_number: String.to_integer(params["circuit_number"])
    }

    with {:ok, new_circuit} <- Circuits.create_circuit(data) do

      circuits = get_circuits(socket)
      circuits = [new_circuit | circuits]

      {:noreply, assign(socket, :circuits, circuits)}
    end
  end

  def get_circuits(socket) do
    socket.assigns.circuits
  end

end
