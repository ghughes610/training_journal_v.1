defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts
  @impl true
  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts()
    workout = workouts |> Enum.random()

    socket =
      assign(socket,
        workout: workout,
        workouts: workouts,
        unfinished_workouts: Enum.filter(workouts, fn workout -> workout.completed == false end),
        editing: %{id: 14, name: "", type: "", metadata: %{}}
      )

    {:ok, socket}
  end

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

  def handle_event("_workout", %{"id" => id}, socket) do
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
        %{"name" => name, "type" => type, "metadata" => metadata},
        socket
      ) do
    metadata =
      metadata
      |> JSON.decode()
      |> elem(1)

    with {:ok, new_workout} <-
           Workouts.create_workout(%{
             name: name,
             completed: false,
             finger_training: true,
             cross_training: false,
             date: Timex.now(),
             type: type,
             metadata: metadata
           }) do
      workouts = get_workouts(socket)
      workouts = [new_workout | workouts]

      {:noreply, assign(socket, :workouts, workouts)}
    end
  end

  defp update_workout(workouts, new_workout) do
    Enum.map(workouts, fn workout ->
      if workout.id == new_workout.id do
        new_workout
      else
        workout
      end
    end)
  end

  defp get_workouts(socket) do
    socket.assigns.workouts
  end

  defp link_body(workout) do
    assigns = %{name: workout.name, date: workout.date}

    ~L"""
    <%= @name %>
    """
  end

  defp card_body(selected_workout) do
    assigns = %{selected_workout: selected_workout}

    ~L"""
    <div class="card">
      <div class="header">
        <h2><%= @selected_workout.name %></h2>
        <button
          phx-click="toggle-status"
          phx-value-id="<%= @selected_workout.id %>"
          phx-disable-with="Saving...">
         Completed: <%= @selected_workout.completed %>
        </button>
      </div>
      <div class="body">
        <div class="row">
          <div class="deploys">
            <span>
              Fingers: <%= @selected_workout.finger_training %>
            </span>
          </div>
          <span>
            Cross Training: <%= @selected_workout.cross_training %>
          </span>
        </div>
        <blockquote>
          <%= @selected_workout.date %>
        </blockquote>
      </div>
    </div>
    """
  end

  defp exercise_form(selected_workout) do
    assigns = %{selected_workout: selected_workout}

    ~L"""
    <div class="card">
      <div class="body">
        <div class="row">
          <div class="deploys">
            <span>
              Fingers: <%= @selected_workout.finger_training %>
            </span>
          </div>
          <span>
            Cross Training: <%= @selected_workout.cross_training %>
          </span>
        </div>
        <blockquote>
          <%= @selected_workout.date %>
        </blockquote>
        <blockquote>
          <%= @selected_workout.completed %>
        </blockquote>
      </div>
    </div>
    """
  end
end
