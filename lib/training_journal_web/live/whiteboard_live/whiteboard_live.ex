defmodule TrainingJournalWeb.WhiteboardLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts

    def mount(%{"id" => id}, _session, socket) do
    full_workout = Workouts.get_full_workout(String.to_integer(id))
    socket = assign(socket, items: full_workout.circuit)
    {:ok, socket}
  end
end
