defmodule TrainingJournalWeb.CreateWorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Builders.NameBuilder,
    Calculators.ShouldTrainCalculator,
    Workouts
    }

  @impl true
  def mount(_params, _session, socket) do
    todays_workouts = Workouts.list_workouts_day(Timex.now())
    socket = assign(socket, todays_workouts: todays_workouts)

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

      {:noreply, assign(socket, :workouts, workouts)}
    end
  end

  def get_workouts(socket) do
    socket.assigns.workouts
  end
end
