defmodule TrainingJournalWeb.ComponentsLive.ComponentsLive do
use TrainingJournalWeb, :live_view

  def make_slider(name, min \\ 0, max \\ 10) do
    assigns = %{
      min: min,
      max: max,
      name: name
      }

    ~L"""
    <div class="flex place-content-center text-cyan-50"><%= String.capitalize(@name) |> String.replace("_", " ")  %></div>
    <div class="flex place-content-center">
      <div class="m-2 text-red-500"><%= @min %></div>
        <input type="range" id="volume" name="<%= @name %>" min="<%= @min %>" max="<%= @max %>">
      <div class="m-2 text-green-500"><%= @max %></div>
    </div>
    """
  end

  def make_custom_slider(name, display_name, min, max) do
    assigns = %{
      min: min,
      max: max,
      name: name,
      display_name: display_name
      }

    ~L"""
    <div class="flex place-content-center text-cyan-50"><%= String.capitalize(@display_name) %></div>
    <div class="flex place-content-center">
      <div class="m-2 text-red-500"><%= @min %></div>
        <input type="range" id="volume" name="<%= @name %>" min="<%= @min %>" max="<%= @max %>">
      <div class="m-2 text-green-500"><%= @max %></div>
    </div>
    """
  end

   def expand_card(selected_workout) do
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
          Date: <%= Timex.format!(@selected_workout.date, "{M}-{D}-{YYYY}") %>
        </blockquote>
        <blockquote>
          Completed: <%= @selected_workout.completed %>
        </blockquote>
      </div>
    </div>
    """
  end

  def card_component(attrs) do
    assigns = %{attrs: attrs}
    ~L"""
    <div class="flex flex-col m-8 mr-3.5 max-w-sm rounded overflow-hidden shadow-lg bg-blue-500">
        <div class="px-6 py-4">
        <div class= "flex justify-around items-center font-bold text-xl mb-2">
          <h3><%= attrs.name %></h3>
              <button phx-click="delete_attrs" phx-value-id="<%= attrs.id %>" class="m-1 p-2 max-w-sm rounded overflow-hidden shadow-lg bg-red-500">X</button>
              <button phx-click="expand_attrs" phx-value-id="<%= attrs.id %>" class="m-1 p-2 max-w-sm rounded overflow-hidden shadow-lg bg-red-500">+</button>
            </div>
            <%= if attrs.completed  do %>
            <%= TrainingJournalWeb.ComponentsLive.ComponentsLive.exercise_form(attrs) %>
            <% end %>
          </div>
        </div>
    </div>
    """
  end

end
