defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts

  def mount(_params, _session, socket) do
    workouts = Workouts.list_workouts()

    socket =
      assign(socket,
        workouts: workouts,
        editing: %{id: 0, name: "", type: ""}
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

  def render(assigns) do
    ~L"""
    <div >
      <div class="flex-col">
        <div class="w-100">
          <form phx-submit="create_workout" >
          <input type="text" placeholder="name" name="name" class="m-10 p-1"/>
          <input type="text" placeholder="type" name="type" class="m-10 p-1"/>
          <button class="bg-indigo-600 text-white text-sm leading-6 font-medium py-2 px-3 rounded-lg bg-green-600" type="submit">create workout</button>
          </form>
        </div>
      <div class="">
          <%= for workout <- @workouts do %>
            <div class="m-8 max-w-sm rounded overflow-hidden shadow-lg bg-blue-500">
                <div class="px-6 py-4">
                    <div class= "flex justify-between items-center font-bold text-xl mb-2">
                      <%= live_patch link_body(workout),
                        to: Routes.live_path(
                        @socket,
                        __MODULE__,
                        id: workout.id
                      ) %>
                      <button phx-click="delete_workout" phx-value-id="<%= workout.id %>" class="m-3 p-3 max-w-sm rounded overflow-hidden shadow-lg bg-red-500">X</button>
                    </div>
                  </div>
                </div>
            </div>
          <% end %>
        </div>
        <div >
      </div>
    </div>
    """
  end

  def handle_event("delete_workout", %{"id" => id}, socket) do
    workouts = get_workouts(socket)
    workout = get_workout_by_id(workouts, id)

    with {:ok, deleted_workout} <- Workouts.delete_workout(workout) do
      workouts = Enum.filter(workouts, fn workout -> workout.id != deleted_workout.id end)

      {:noreply, assign(socket, :workouts, workouts)}
    end


  end

  def handle_event("create_workout", %{"name" => name, "type" => type}, socket) do
    with {:ok, new_workout} <-
           Workouts.create_workout(%{
             name: name,
             completed: false,
             finger_training: true,
             cross_training: false,
             date: Timex.now(),
             type: type
           }) do
      workouts = get_workouts(socket)
      workouts = [new_workout | workouts]

      {:noreply, assign(socket, :workouts, workouts)}
    end
  end

  defp get_workout_by_id(workout, id) do
    Enum.find(workout, fn workout -> workout.id == String.to_integer(id) end)
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
end
