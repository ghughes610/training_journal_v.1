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

   def handle_event(
        "create_exercise",
        %{
          "name" => name,
          "metadata" => metadata,
          "sets" => sets,
          "reps" => reps,
          "weight" => weight
          },
        socket
      ) do

    metadata =
      metadata
      |> JSON.decode()
      |> elem(1)

    with {:ok, new_exercise} <-
           Exercises.create_exercise(%{
             name: name,
             completed: false,
             metadata: metadata,
             circuit_id: socket.assigns.id,
             sets: sets,
             reps: reps,
             weight: weight
           }) do

      exercises = get_exercises(socket)
      exercises = [new_exercise | exercises]

      {:noreply, assign(socket, :exercises, exercises)}
    end
  end

  def get_exercises(socket) do
    socket.assigns.exercises
  end

end
