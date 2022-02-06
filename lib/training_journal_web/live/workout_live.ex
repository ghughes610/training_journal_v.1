defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts
  alias TrainingJournal.Workouts.Workout

  def mount(_params, _session, socket) do

    socket = assign(socket, workouts: Workouts.list_workouts)
    IO.puts("lookup")
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div>
    <%= for workout <- @workouts do %>
    <h1><%= workout.name %></h1>
    <% end %>
    </div>
    """
  end
end
