defmodule TrainingJournalWeb.IndexLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts

  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts()

    socket = assign(socket, workouts: workouts)
    {:ok, socket}
  end
end
