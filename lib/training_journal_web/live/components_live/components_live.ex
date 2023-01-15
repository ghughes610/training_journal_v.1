defmodule TrainingJournalWeb.ComponentsLive.ComponentsLive do
  use TrainingJournalWeb, :view

  def header(assigns) do
    ~H"""
    <h2 class="m-1.5 text-xl font-bold text-base font-medium text-black hover:text-gray-500"><a href="http://localhost:4000/">Training Journal</a></h2>
    """
  end

  def section_header(assigns) do
    ~H"""
    <div class="bg-indigo-500">
      <div class="mx-auto max-w-7xl py-16 px-4 sm:py-24 sm:px-6 lg:px-8">
        <div class="text-center">
          <p class="mt-1 text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl lg:text-6xl">Take control of your team.</p>
          <p class="mx-auto mt-5 max-w-xl text-xl text-gray-500">Start building for free, then add a site plan to go live. Account plans unlock additional features.</p>
        </div>
      </div>
    </div>
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

  def make_text_input(field, display_name \\ nil) do
    assigns = %{
      field: field,
      display_name: display_name
    }
    if display_name == nil do
      ~L"""
      <div>
        <div class="relative my-1.5 rounded-md shadow-sm">
          <input type="text" placeholder="<%= String.capitalize(@field) %>" name="<%= @field %>" class="p-3 block w-full rounded-md border-gray-300 pr-10 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
        </div>
      </div>
      """
    else
      ~L"""
      <div>
        <div class="relative my-1.5 rounded-md shadow-sm">
          <input type="text" placeholder="<%= @display_name %>" name="<%= @field %>" class="p-3 block w-full rounded-md border-gray-300 pr-10 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
        </div>
      </div>

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

  def circuit_card(assigns) do
    ~H"""
      <%= for i <- @items do %>
        <li class="col-span-1 flex rounded-md shadow-sm">
          <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if i.id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
            <%= i.number_of_exercises %>
          </div>
          <div class="flex flex-1 items-center justify-between truncate rounded-r-md border-t border-r border-b border-gray-200 bg-white">
            <div class="flex-1 truncate px-4 py-2 text-sm">
              <a class="font-medium text-gray-900 hover:text-gray-600">
                          <%= live_patch i.name,
                            to: Routes.live_path(
                            @socket,
                            @module,
                            id: i.id
                          ) %>
                        </a>

              <p class="text-gray-500"><%= Timex.format!(i.inserted_at, "{M}/{D}/{YYYY}") %></p>
              </div>
              <div class="flex-shrink-0 pr-2">
                <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white bg-transparent text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                    <%= link("X",
                            to: "#",
                            phx_click: "delete",
                            phx_value_id: i.id
                    ) %>
                </button>
              </div>
            </div>
          </li>
      <% end %>
    """
  end

  def workout_card(assigns) do
    ~H"""
    <%= for i <- @items do %>
      <li class="col-span-1 flex rounded-md shadow-sm">
        <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if i.id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
          <%= String.first(i.type)  %>
          <a href="/whiteboard/workout?=#{}"></a>
        </div>
          <div class="flex flex-1 items-center justify-between truncate rounded-r-md border-t border-r border-b border-gray-200 bg-white">
          <div class="flex-1 truncate px-4 py-2 text-sm">
            <a class="font-medium text-gray-900 hover:text-gray-600">
            <%= live_patch i.name,
            to: Routes.live_path(
            @socket,
            @module,
            id: i.id
            ) %>
            </a>
            <p class="text-2xl"><%= if_else_emoji(i.metadata["morning_workout"], "☀️", "🌗") %></p>
            <p class="text-2xl"><%= if_else_emoji(i.finger_training, "✋ 🏋️", "🏋️") %></p>
            <p class="text-gray-500"><%= Timex.format!(i.inserted_at, "{M}/{D}/{YYYY}") %></p>
          </div>
          <div class="flex-shrink-0 pr-2">
            <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white bg-transparent text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
            <%= link("X",
            to: "#",
            phx_click: "delete",
            phx_value_id: i.id
            ) %>
            </button>
          </div>
        </div>
      </li>
    <% end %>
    """
  end

  def exercise_card(assigns) do
    ~H"""
    <%= for i <- @items do %>
      <li class="col-span-1 flex rounded-md shadow-sm">

      <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if i.id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
        <%= link("√",
            to: "#",
            phx_click: "complete_set",
            phx_value_id: i.id
            ) %>
      </div>
            <div class="flex flex-1 items-center justify-between truncate rounded-r-md border-t border-r border-b border-gray-200 bg-white">
            <div class="flex-1 truncate px-4 py-2 text-sm">
              <a class="font-medium text-gray-900 hover:text-gray-600">
              <%= live_patch i.name,
              to: Routes.live_path(
              @socket,
              @module,
              id: i.id
              ) %>
              </a>
              <p class="text-gray-500"><%= Timex.format!(i.inserted_at, "{M}/{D}/{YYYY}") %></p>
              <p class="text-gray-500"><%= i.completed_sets %></p>
            </div>
            <div class="flex-shrink-0 pr-2">
              <button type="button" class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-white bg-transparent text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
              <%= link("X",
              to: "#",
              phx_click: "delete",
              phx_value_id: i.id
              ) %>
              </button>
            </div>
        </div>
      </li>
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

  def if_else_emoji(field, emoji_1, emoji_2) do
    if field do
      emoji_1
     else
      emoji_2
    end
  end

  def make_whiteboard_button(assigns) do
    ~H"""
    <span class="mt-2 ml-1 isolate inline-flex rounded-md shadow-sm">
      <button type="button" class="relative inline-flex items-center rounded-md border border-gray-300 bg-white px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 focus:z-10 focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500">
        <!-- Heroicon name: mini/bookmark -->
        <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
        <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" /></svg>

      </button>
    </span>
    """
  end

  def random_color_div(field) do
    assigns = %{
      id: true,
      field: field
    }
    ~L"""
    <div class={["flex-shrink-0 flex items-center justify-center w-16 bg-pink-600 text-white text-sm font-medium rounded-l-md", (if @id, do: " #{Enum.random([" bg-blue-600", " bg-red-600", "  bg-green-600", "  bg-gray-600"])}", else: " bg-blue-600") ]}>
      <%= @field %>
    </div>
    """
  end

end
