defmodule TrainingJournalWeb.CircuitLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Circuits,
    Exercises,
    Workouts,
    Repo
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

  def handle_event("complete_circuit", _, socket) do
    circuit = socket
    IO.inspect(socket.assigns.items, label: "lib/training_journal_web/live/circuit_live/circuit_live.ex:29")

    Enum.map(socket.assigns.items, &(complete_all_sets(&1, circuit)))

    case Circuits.update_circuit(circuit, %{ "completed" => true }) do
       {:ok, circuits} -> IO.inspect(circuits)
       {:error, error} -> IO.puts("not updating here is the error #{error}")
    end

    {:noreply, socket}
  end

  def handle_event("create_circuit", params, socket) do
    data = %{
      name: params["name"],
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
      circuits = [ new_circuit | circuits]

      {:noreply, assign(socket, :items, circuits)}
    end
  end

  def get_circuits(socket), do: socket.assigns.items

  def complete_all_sets(exercise, circuit) do
    IO.inspect(exercise, label: :exercise)
    IO.inspect(circuit, label: :circuit)
    case Exercises.update_exercise(exercise, %{ "completed_sets" => circuit.sets }) do
    {:ok, exercise} -> IO.inspect(exercise)
       {:error, error} -> IO.puts("not updating here is the error #{error}")
    end
  end

end
