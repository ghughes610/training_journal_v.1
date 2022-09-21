defmodule TrainingJournalWeb.SearchWorkoutsLive do
    use TrainingJournalWeb, :live_view

  def mount(_params, _session, socket) do

    socket =
      assign(socket,
        workouts: []
      )

    {:ok, socket}
  end
end
