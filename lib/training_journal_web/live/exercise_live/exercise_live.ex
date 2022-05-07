defmodule TrainingJournalWeb.ExerciseLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Exercises

  @impl true
  def mount(_params, _session, socket) do
    exercises = Exercises.list_exercises()

    socket =
      assign(socket,
        exercises: exercises
      )
      IO.inspect(socket.assigns.id)
    {:ok, socket}
  end

  def handle_event(
    "create_exercise",
    %{"name" => name, "reps" => reps, "sets" => sets, "metadata" => metadata, "weight" => weight},
    socket
    ) do
      metadata =
        metadata
        |> JSON.decode()
        |> elem(1)
        with {:ok, new_exercise} <-
                Exercises.create_exercise(%{
                  name: name,
                  reps: reps,
                  sets: sets,
                  weight: weight,
                  metadata: metadata,
                  circuit_id: socket.assigns.id
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
