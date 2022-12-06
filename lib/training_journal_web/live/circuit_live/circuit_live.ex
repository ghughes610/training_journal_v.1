defmodule TrainingJournalWeb.CircuitLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Builders.NameBuilder,
    Circuits,
    Workouts
  }

  def mount(%{"id" => id}, _session, socket) do
    full_workout = Workouts.get_full_workout(String.to_integer(id))
    socket = assign(socket, items: full_workout.circuit, id: id, module: TrainingJournalWeb.ExerciseLive)

    {:ok, socket}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    circuits = get_circuits(socket)
    circuit = Circuits.get_circuit!(id)

    with {:ok, deleted_circuit} <- Circuits.delete_circuit(circuit) do
      circuits = Enum.filter(circuits, fn circuit -> circuit.id != deleted_circuit.id end)

      {:noreply, assign(socket, :items, circuits)}
    end
  end

  def handle_event("complete_set", %{"value" => id}, socket) do
    # dont think i should be making another call to the database just filtering the full_workout.circuits for the id should be good but i cannot seem to get the circuit id to be included in the preload
    circuit = Circuits.get_circuit!(String.to_integer(id))
    attrs = %{ "metadata" => %{"completed_sets" => circuit.metadata["completed_sets"] + 1}}
    result = case Circuits.update_circuit(circuit, attrs) do
       {:ok, circuits} -> IO.inspect(circuits)
       {:error, error} -> IO.puts("not updating here is the error #{error}")
    end

    IO.inspect(result, label: "result")
    {:noreply, socket}
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
      metadata: %{"completed_sets" => 0},
      circuit_number: String.to_integer(params["circuit_number"])
    }

    with {:ok, new_circuit} <- Circuits.create_circuit(data) do

      circuits = get_circuits(socket)
      circuits = [new_circuit | circuits]

      {:noreply, assign(socket, :items, circuits)}
    end
  end

  def get_circuits(socket) do
    socket.assigns.items
  end

end
