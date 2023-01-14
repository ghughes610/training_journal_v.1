defmodule TrainingJournalWeb.ExerciseLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Calculators.ExerciseCalculator,
    Circuits,
    Exercises
  }


  @impl true
  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)
    circuit = Circuits.get_circuit!(id)
    exercises = Exercises.get_circuit_exercises(id)

    socket = assign(socket,
    items: exercises,
    module: __MODULE__,
    id: id,
    circuit: circuit)


    {:ok, socket}
  end

  @impl true
  def handle_event("generate_exercise", params, socket) do
    weight = if params["weight"] == "" do
      0
    else
      String.to_integer(params["weight"])
    end

    data = %{
      reps: ExerciseCalculator.calculate_exercise_reps(weight),
      weight: weight,
      push: params["push"] || false,
      pull: params["pull"] || false,
      dynamic: params["dynamic"] || false,
      isometric: params["isometric"] || false,
      over_head: params["over_head"] || false,
      fingers: params["fingers"] || false,
    }

    name = if params["name"] == "" || params["name"] == nil do
      ExerciseCalculator.calculate_exercise(params)
    else
      params["name"]
    end

    data =
      data
      |> Map.put(:name, name)
      |> Map.put(:circuit_id, socket.assigns.id)
      |> Map.put(:metadata, %{})

      # if socket.assigns.circuit.metadata["completed_sets"] ==  do

    if socket.assigns.circuit.number_of_exercises <= Enum.count(socket.assigns.items) do

      {:noreply, put_flash(socket, :error, "You have already made #{socket.assigns.circuit.number_of_exercises} exercises for this circuit!")}
    else
      with {:ok, new_exercise} <- Exercises.create_exercise(data) do

        exercises = get_exercises(socket)
        exercises = [new_exercise | exercises]

        {:noreply, assign(socket, :items, exercises)}
      end
    end
  end


  def handle_event("complete_set", %{"id" => id}, socket) do
    exercise = Exercises.get_exercise!(id)
    circuit = Circuits.get_circuit!(exercise.circuit_id)

    if circuit.sets != exercise.completed_sets do

      attrs = %{ "completed_sets" => exercise.completed_sets + 1}

      case Exercises.update_exercise(exercise, attrs) do
       {:ok, _exercise} ->
          exercises = Exercises.get_circuit_exercises(circuit.id)
          socket = assign(socket, :items, exercises)
         {:noreply, put_flash(assign(socket, :items, exercises), :info, "complete 1 set for #{exercise.name}")}

       {:error, error} -> IO.inspect(error, label: :error)
      end

    else
      {:noreply, put_flash(socket, :error, "sets are completed for #{exercise.name}")}
    end
  end

    @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    exercise = Exercises.get_exercise!(id)

    exercises = with {:ok, deleted_exercise} <- Exercises.delete_exercise(exercise) do
      Enum.filter(get_exercises(socket), fn exercise -> exercise.id != deleted_exercise.id end)
    end

    {:noreply, assign(socket, :items, exercises)}
  end

  def get_exercises(socket), do: socket.assigns.items
end
