defmodule TrainingJournalWeb.WorkoutLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Workouts
  alias TrainingJournal.Circuits

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        workouts: Workouts.list_workouts(),
        circuits: Circuits.list_circuits()
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="flex justify-between">
      <div class="ml-20 flex-col justify-between content-center">
        <%= for workout <- @workouts do %>
          <div class="m-5 max-w-sm rounded overflow-hidden shadow-lg bg-blue-500">
              <div class="px-6 py-4">
                <div class="font-bold text-xl mb-2"><%= workout.name%></div>
                  <p class="text-gray-700 text-base">
                    Type: <%= workout.type%> exercise
                  </p>
                </div>
                <div class="px-6 pt-4 pb-2">
                  <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= workout.date |> Timex.format!("{YYYY}-{0M}-{0D}") %></span>
                  <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= if workout.cross_training , do: "#Cross", else: "#Finger" %></span>
                  <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= workout.date |> Timex.weekday() |> Timex.day_name() %></span>
              </div>
          </div>
        <% end %>
      </div>

      <div class="ml-20 flex-col justify-between content-center">
        <%= for circuit <- @circuits do %>
          <div class="m-5 max-w-sm rounded overflow-hidden shadow-lg bg-red-500">
            <div class="px-6 py-4">
              <div class="font-bold text-xl mb-2"><%= circuit.name%></div>
                <p class="text-gray-700 text-base">
                  Focus: <%= circuit.focus%> exercise
                </p>
                <div class="px-6 pt-4 pb-2">
                    <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= circuit.inserted_at |> Timex.format!("{YYYY}-{0M}-{0D}") %></span>
                    <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2">#<%= circuit.metadata["feeling"] %></span>
                    <span class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold text-gray-700 mr-2 mb-2"><%= circuit.inserted_at |> Timex.weekday() |> Timex.day_name() %></span>
                </div>
              </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
