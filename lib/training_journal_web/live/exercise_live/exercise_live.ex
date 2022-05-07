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
      IO.inspect(socket)

    {:ok, socket}
  end
end
