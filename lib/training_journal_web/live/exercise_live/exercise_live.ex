defmodule TrainingJournalWeb.ExerciseLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Calculators.ExerciseCalculator,
    Exercises
  }


  @impl true
  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)
    exercises = Exercises.get_circuit_exercises(id)
    socket = assign(socket, exercises: exercises, id: id )

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

    name = if params["name"] == "" do
      ExerciseCalculator.calculate_exercise(params)
    else
      params["name"]
    end

    data =
      data
      |> Map.put(:name, name)
      |> Map.put(:circuit_id, socket.assigns.id)
      |> Map.put(:metadata, %{})

    with {:ok, new_exercise} <- Exercises.create_exercise(data) do

      exercises = get_exercises(socket)
      exercises = [new_exercise | exercises]

      {:noreply, assign(socket, :exercises, exercises)}
    end
  end

  def get_exercises(socket) do
    socket.assigns.exercises
  end

   def heavy_or_light(lb) do
    cond do
      lb >= 1 && lb <= 30 -> "light"
      lb >= 31 && lb <= 50 -> "medium"
      lb >= 51 && lb <= 70 -> "heavy"
      true -> "extra heavy"
    end
  end

end
