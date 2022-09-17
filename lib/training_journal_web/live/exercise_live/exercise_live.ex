defmodule TrainingJournalWeb.ExerciseLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Exercises

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)
    exercises = Exercises.get_circuit_exercises(id)
    socket = assign(socket, exercises: exercises, id: id )

    {:ok, socket}
  end

  @impl true
   def handle_event("create_exercise", params, socket) do

    data = %{
      name: "make this with conditionals",
      reps: String.to_integer(params["reps"]),
      weight: params["weight"],
      push: params["push"],
      pull: params["pull"],
      dynamic: params["dynamic"],
      isometric: params["isometric"],
      over_head: params["over_head"],
      fingers: params["fingers"],
      circuit_id: socket.assigns.id,
      metadata: %{}
    }

    with {:ok, new_exercise} <- Exercises.create_exercise(data) do

      exercises = get_exercises(socket)
      exercises = [new_exercise | exercises]

      {:noreply, assign(socket, :exercises, exercises)}
    end
  end

  def get_exercises(socket) do
    socket.assigns.exercises
  end

end
