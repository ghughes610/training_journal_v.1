defmodule TrainingJournalWeb.CardLive.CardComponent do
  use TrainingJournalWeb, :live_component
  def render(assigns) do
    ~L"""
    <div class="flex-col m-8 max-w-sm rounded overflow-hidden shadow-lg bg-blue-500 p-3"><%= @workout.name %></div>

    """
  end

end
