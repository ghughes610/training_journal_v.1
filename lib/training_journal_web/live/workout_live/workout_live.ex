defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts
  @impl true
  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts()

    socket =
      assign(socket,
        workouts: workouts,
        unfinished_workouts: Enum.filter(workouts, fn workout -> workout.completed == false end)
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _url, socket) do
    id = String.to_integer(id)

    workout = Workouts.get_workout!(id)

    socket = assign(socket, selected_workout: workout)

    {:noreply, socket}
  end

  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  def handle_event("delete_workout", %{"id" => id}, socket) do
    workouts = get_workouts(socket)
    workout = Workouts.get_workout!(id)

    with {:ok, deleted_workout} <- Workouts.delete_workout(workout) do
      workouts = Enum.filter(workouts, fn workout -> workout.id != deleted_workout.id end)

      {:noreply, assign(socket, :workouts, workouts)}
    end
  end

  def handle_event("expand_workout", %{"id" => id}, socket) do
    workout = Workouts.get_workout!(id)

    {:ok, _workout} =
      Workouts.update_workout(
        workout,
        %{completed: !workout.completed}
      )

    workouts = Workouts.list_workouts()

    socket = assign(socket, workouts: workouts)

    {:noreply, socket}
  end

  def handle_event("workout", %{"id" => id}, socket) do
    workout = Workouts.get_workout!(id)

    {:ok, _workout} =
      Workouts.update_workout(
        workout,
        %{completed: !workout.completed}
      )

    workouts = Workouts.list_workouts()

    socket = assign(socket, workouts: workouts)

    {:noreply, socket}
  end

  def handle_event("update_editing", %{"id" => id}, socket) do
    editing = Workouts.get_workout!(id)

    {:noreply, assign(socket, :editing, editing)}
  end

   def handle_event(
        "create_workout",
        %{
        "name" => name,
        "type" => type,
        "cross_training" => cross_training,
        "finger_training" => finger_training,
        "freshness" => freshness,
        "days_on" => days_on,
        "body_weight" => body_weight
        },
        socket
      ) do
        IO.puts("here match /4")

    metadata_attrs =
      %{}
      |> Map.put("freshness", freshness)
      |> Map.put("days_on", days_on)
      |> Map.put("body_weight", body_weight)


      # build_workout_metadata(metadata_attrs)

    with {:ok, new_workout} <-
           Workouts.create_workout(%{
             name: name,
             completed: false,
             finger_training: String.to_atom(finger_training),
             cross_training: String.to_atom(cross_training),
             date: Timex.now(),
             type: type,
             metadata: metadata_attrs
           }) do

      workouts = get_workouts(socket)
      workouts = [new_workout | workouts]

      {:noreply, assign(socket, :workouts, workouts)}
    end
  end


  def handle_event("create_workout", params, socket) do
    IO.puts("catch all")
    IO.inspect(params)
    with {:ok, new_workout} <-
           Workouts.create_workout(%{
             name: "name",
             completed: false,
            #  finger_training: String.to_atom(finger_training),
             finger_training: false,
             cross_training: false,
             date: Timex.now(),
             type: "that",
             metadata: %{}
           }) do

      workouts = get_workouts(socket)
      workouts = [new_workout | workouts]

      {:noreply, assign(socket, :workouts, workouts)}
    end
  end

  # defp update_workout(workouts, new_workout) do
  #   Enum.map(workouts, fn workout ->
  #     if workout.id == new_workout.id do
  #       new_workout
  #     else
  #       workout
  #     end
  #   end)
  # end

  defp get_workouts(socket) do
    socket.assigns.workouts
  end

  # defp build_workout_metadata(metadata_attrs) do
  #   freshness = String.to_integer(metadata_attrs["freshness"])

  #   should_train =
  #     cond do
  #       freshness >= 8 -> "Yes"
  #       freshness < 7 && freshness >= 6 -> "Maybe"
  #       freshness -> "No"
  #     end

  #   metadata_attrs
  #   |> Map.put("should_train", should_train)

  # end
end
