defmodule TrainingJournalWeb.CreateWorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Calculators.ShouldTrainCalculator,
    Workouts
    }

  @impl true
  def mount(_params, _session, socket) do

    weeks_workouts = Workouts.list_workouts_week(Timex.now())
    socket = assign(
      socket,
      items: weeks_workouts,
      module: TrainingJournalWeb.CircuitLive
    )

  {:ok, socket}
  end

  @impl true
  def handle_event("create_workout", params, socket) do

    data = %{
      name: Timex.now |> Timex.weekday |> Timex.day_name,
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
        day_of_week: Timex.now |> Timex.weekday |> Timex.day_shortname,
        morning_workout: am_workout?()
       }
    }

    with {:ok, new_workout} <- Workouts.create_workout(data) do

      socket = assign(socket, items: [new_workout | get_workouts(socket)])

      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    workout = Workouts.get_workout!(id)

    workouts = with {:ok, deleted_workout} <- Workouts.delete_workout(workout) do
      Enum.filter(get_workouts(socket), fn workout -> workout.id != deleted_workout.id end)
    end

    {:noreply, assign(socket, :items, workouts)}
  end

  def get_workouts(socket), do: socket.assigns.items

  def am_workout?(time \\ Timex.now()) do
    case Timex.compare(Timex.set(time, [hour: 12]), time) do
      -1 -> true
      1 -> false
      _ -> true
    end
  end
end
