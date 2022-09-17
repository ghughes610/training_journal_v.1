defmodule TrainingJournalWeb.ComponentsLive.ComponentsLive do
  use TrainingJournalWeb, :view

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

  def make_custom_slider(name, display_name, min \\ 0, max \\ 10) do
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

  def expand_workout_card(selected_workout) do
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
        <blockquote>
          Cross Training: <%= @selected_workout.cross_training %>
        </blockquote>
        <blockquote>
          Finger Training: <%= @selected_workout.finger_training %>
        </blockquote>
      </div>
    </div>
    """
  end

  def make_text_input(field, display_name \\ nil) do
    assigns = %{
      field: field,
      display_name: display_name
    }
    if display_name == nil do
      ~L"""
      <input type="text" placeholder="<%= String.capitalize(@field) %>" name="<%= @field %>" class="m-3 p-2 text-center border border-green-500"/>
      """
    else
      ~L"""
      <input type="text" placeholder="<%= @display_name %>" name="<%= @field %>" class="m-3 p-2 text-center border border-green-500"/>
      """
    end
  end

  def make_number_input(field, display_name \\ nil, min \\ 0, max \\ 10, default \\ 5) do
    assigns = %{
      field: field,
      display_name: display_name,
      min: min,
      max: max,
      default: default
    }
    if display_name == nil do
      ~L"""
      <label for="<%= @field %>"><%= @field %></label>
      <input type="number" id="<%= @field %>"
        placeholder="<%= String.capitalize(@field) %>"
        name="<%= @field %>"
        min="<%= @min %>"
        max="<%= @max %>"
        value="<%= @default %>"
        class="m-3 p-2 text-center border border-green-500"
      />
      """
    else
      ~L"""
      <label for="<%= @field %>"><%= @display_name %></label>
      <input
        id="<%= @field %>"
        type="number"
        placeholder="<%= @display_name %>"
        name="<%= @field %>"
        min="<%= @min %>"
        max="<%= @max %>"
        value="<%= @default %>"
        class="m-3 p-2 text-center border border-green-500"
      />
      """
    end
  end

  def make_radio_button(field, display_name \\ nil) do
    assigns = %{
      field: field,
      display_name: display_name
    }

    if display_name == nil do
      ~L"""
      <div class="flex items-center mb-4">
      <input id="default-checkbox" name="<%= @field %>" type="checkbox" value="true" class="ml-3 w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
      <label for="default-checkbox" class="ml-3 text-xl font-medium text-gray-900 dark:text-gray-300"><%= @field %></label>
      </div>
      """
    else
      ~L"""
      <div class="flex items-center mb-4">
      <input id="default-checkbox" name="<%= @field %>" type="checkbox" value="true" class="ml-3 w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
      <label for="default-checkbox" class="ml-3 text-xl font-medium text-gray-900 dark:text-gray-300"><%= @display_name %></label>
      </div>
      """
    end
  end

  def make_select_menu(field, display_name \\ nil, opts \\ []) do
    assigns = %{
      field: field,
      display_name: display_name,
      opts: opts
    }
    ~L"""
    <label for="<%= @field %>" class="block mb-2 text-base font-medium text-gray-900 dark:text-gray-400"><%= @display_name %></label>
    <select id="<%= @field %>" class="block py-2 px-3 text-base text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">

    <%= for opt <- @opts do %>
      <option value="opt"><%= opt %></option>
    <% end %>

    </select>
    """
  end
end
