defmodule TrainingJournalWeb.ComponentsLive.ComponentsLive do
  use TrainingJournalWeb, :view

  def header(assigns) do
    ~H"""
    <h2 class="m-1.5 text-xl font-bold text-base font-medium text-black hover:text-gray-500"><a href="http://localhost:4000/">Training Journal</a></h2>
    """
  end

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
    <div>
      <div>
        <blockquote>
          Cross Training: <%= @selected_workout.cross_training %>
        </blockquote>
        <blockquote>
          Finger Training: <%= @selected_workout.finger_training %>
        </blockquote>
        <blockquote>
          Days On: <%= @selected_workout.metadata["days_on"] %>
        </blockquote>
        <blockquote>
          Freshness: <%= @selected_workout.metadata["freshness"] %>/10
        </blockquote>
        <blockquote>
          Should Train: <%= @selected_workout.metadata["should_train"] %>
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
      <label for="<%= @field %>" class="block mb-2 text-base font-medium text-gray-900 dark:text-gray-400"><%= @field %></label>
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
      <label for="<%= @field %>" class="block mb-2 text-base font-medium text-gray-900 dark:text-gray-400"><%= @display_name %></label>
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
    <select id="<%= @field %>" name="<%= @field %>" class="block py-2 px-3 text-base text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
      <%= for opt <- @opts do %>
        <option value="<%= opt %>"><%= opt %></option>
      <% end %>
    </select>
    """
  end

  def make_delete_button(struct) do
    assigns = %{
      struct: struct
    }
    ~L"""
    <button phx-click="delete" phx-value-id="<%= @struct.id %>" class="m-5 p-2 max-w-sm rounded overflow-hidden shadow-lg bg-red-500">X</button>
    """
  end

  def stat_container(assigns) do
    ~H"""
    <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6">
      <dt class="truncate text-sm font-medium text-gray-500"><%= @data %></dt>
      <dd class="mt-1 text-3xl font-semibold tracking-tight text-gray-900">71,897</dd>
    </div>
    """
  end


  def card(assigns) do
    ~H"""
    <%= for w <- @weeks_workouts do %>
    <div class="text-white m-2">
    <div class="overflow-hidden rounded-lg bg-white px-4 py-5 shadow sm:p-6">
          <dt class="truncate text-sm font-medium text-gray-500"><%= w.type %></dt>
          <dd class="mt-1 text-3xl font-semibold tracking-tight text-gray-900"><%= Timex.format!(w.inserted_at, "{YYYY}-{0M}-{0D}") %> </dd>
          <span class="text-black">
            <%= link("Delete",
                      to: "#",
                      phx_click: "delete",
                      phx_value_id: w.id
            ) %>
          </span>
        </div>
      </div>
    <% end %>
    """
  end

  def nav_menu(assigns) do
    ~H"""
    <div x-data="{ open: false }" @mouseover = "open = true" @click = "open = !open">
      <div
        @mouseover = "open = true"
        class="mr-1 relative text-left">
          <button
            @mouseover = "open = true"
            @keydown.escape.window="open = false"
            class="flex items-center h-8 pl-3 pr-2 border border-black focus:outline-none">
            <span class="text-sm leading-none">
              Navigation
            </span>
            <svg class="w-4 h-4 mt-px ml-2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </button>
          <div
            @mouseover.away = "open = false"
            x-cloak
            x-show="open"
            x-transition:enter="transition ease-out duration-100"
            x-transition:enter-start="transform opacity-0 scale-95"
            x-transition:enter-end="transform opacity-100 scale-100"
            x-transition:leave="transition ease-in duration-75"
            x-transition:leave-start="transform opacity-100 scale-100"
            x-transition:leave-end="transform opacity-0 scale-95"
            class="absolute flex flex-col w-40 mt-1 border border-black shadow-xs bg-white">
            <a class="flex items-center h-8 px-3 text-sm hover:bg-gray-200" href="http://localhost:4000/create_workout">Create A Workout</a>
            <a class="flex items-center h-8 px-3 text-sm hover:bg-gray-200" href="http://localhost:4000/search_workouts">Search Workouts</a>
            <a class="flex items-center h-8 px-3 text-sm hover:bg-gray-200" href="http://localhost:4000/exercises">Exercises</a>
          </div>
      </div>
    </div>
    """
  end

end
