defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Workouts
  }

  @impl true
  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts()

    socket =
      assign(socket,
        items: workouts,
        module: __MODULE__
      )

    {:ok, socket}
  end

  @impl true
  def handle_event("update_editing", %{"id" => id}, socket) do
    editing = Workouts.get_workout!(id)

    {:noreply, assign(socket, :editing, editing)}
  end


  def update_workout(workouts, new_workout) do
    Enum.map(workouts, fn workout ->
      if workout.id == new_workout.id do
        new_workout
      else
        workout
      end
    end)
  end

end
