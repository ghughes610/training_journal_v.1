defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts
  alias TrainingJournal.Workouts.Workout

  def mount(_params, _session, socket) do
    socket = assign(socket, workouts: Workouts.list_workouts())
    IO.puts("lookup")
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div>
      <%= for workout <- @workouts do %>
        <div class="m-5 max-w-sm rounded overflow-hidden shadow-lg">
            <div class="px-6 py-4">
              <div class="font-bold text-xl mb-2"><%= workout.name%></div>
                <p class="text-gray-700 text-base">
                  Type: <%= workout.type%> exercise
                </p>
              </div>
              <div class="px-6 pt-4 pb-2">
                <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= workout.date |> Timex.format!("{YYYY}-{0M}-{0D}") %></span>
                <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2">#fingers</span>
                <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= workout.date |> Timex.weekday() |> Timex.day_name() %></span>
            </div>
        </div>
      <% end %>
    </div>
    """
  end
end
