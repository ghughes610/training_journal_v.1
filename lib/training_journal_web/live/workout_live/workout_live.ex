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
  def handle_event("delete", %{"id" => id}, socket) do
    workout = Workouts.get_workout!(id)

    workouts = with {:ok, deleted_workout} <- Workouts.delete_workout(workout) do
      Enum.filter(TrainingJournalWeb.CreateWorkoutLive.get_workouts(socket), fn workout -> workout.id != deleted_workout.id end)
    end

    {:noreply, assign(socket, :items, workouts)}
  end

  @impl true
  def handle_params(a, b, socket) do
    IO.inspect(a, label: :a)
    IO.inspect(b, label: :b)
    
     {:noreply, socket}
  end

  def handle_event("filter", params, socket) do
    IO.inspect(params, label: :params)

    {:noreply, socket}
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
