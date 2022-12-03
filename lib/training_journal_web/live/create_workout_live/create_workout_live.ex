defmodule TrainingJournalWeb.CreateWorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Builders.NameBuilder,
    Calculators.ShouldTrainCalculator,
    Workouts
    }

  @impl true
  def mount(_params, _session, socket) do
    weeks_workouts = Workouts.list_workouts_week(Timex.now())
    socket = assign(socket, weeks_workouts: weeks_workouts)

    {:ok, socket}
  end

  @impl true
  def handle_event("create_workout", params, socket) do

    data = %{
      name: NameBuilder.build_name(params["type"]),
      type: params["type"],
      finger_training: params["finger_training"] || false,
      cross_training: params["cross_training"] || true,
      completed: false,
      metadata: %{
        notes: params["notes"],
        should_train: ShouldTrainCalculator.should_train(params["freshness"], params["days_on"]),
        freshness: params["freshness"],
        days_on: params["days_on"],
        body_weight: params["body_weight"],
        day_of_week: Timex.now |> Timex.weekday |> Timex.day_shortname
       }
    }

    with {:ok, new_workout} <- Workouts.create_workout(data) do

      workouts = get_workouts(socket)
      workouts = [new_workout | workouts]

      socket = assign(socket, weeks_workouts: workouts)

      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    workouts = get_workouts(socket)
    workout = Workouts.get_workout!(id)

    with {:ok, deleted_workout} <- Workouts.delete_workout(workout) do
      Enum.filter(workouts, fn workout -> workout.id != deleted_workout.id end)
      workouts = get_workouts(socket)
      {:noreply, assign(socket, :workouts, workouts)}
    end
  end


  def get_workouts(socket) do
    socket.assigns.weeks_workouts
  end
end
