defmodule TrainingJournalWeb.Live.ComponentsLive.TableComponents do
  use TrainingJournalWeb, :view


  def table_head(assigns) do
    ~H"""
    <thead class="bg-white">
      <tr>
        <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Name</th>
        <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Load</th>
        <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Reps</th>
        <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Sets</th>
        <th scope="col" class="text-sm font-semibold text-gray-900">Rest Time</th>
      </tr>
    </thead>
    """
  end

  def table_exercises_group(assigns)do
    ~H"""
    <%= for i <- @items do %>
        <tr class="border-t border-gray-200">
          <th colspan="5" scope="colgroup" class="bg-gray-300 px-4 py-2 text-left text-sm font-semibold text-gray-900 sm:px-6">Circuit <%= i.name %></th>
        </tr>
      <%= for e <- i.exercise do %>
        <tr class="border-t border-gray-200">
          <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6"><%= e.name %></td>
          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"><%= e.weight %></td>
          <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"><%= e.reps %></td>
          <td class="whitespace-nowrap px-5 py-4 text-sm text-gray-500"><%= e.completed_sets %>/<%= i.sets %></td>
          <td class="text-center whitespace-nowrap pr-10 py-4 text-sm text-gray-500"><%= i.rest_time %> mins</td>
        </tr>
      <% end %>
    <% end %>
    """
  end
end
