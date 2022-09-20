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

  def make_expand_button(struct) do
    assigns = %{ struct: struct }

    ~L"""
    <button phx-click="expand" phx-value-id="<%= @struct.id %>" class="m-5 p-2 max-w-sm rounded overflow-hidden shadow-lg bg-red-500">+</button>
    """
  end

  def make_card(item) do
    assigns = %{item: item}

    ~L"""
    <div class="w-60 m-2 p-2 bg-white rounded-xl transform transition-all hover:-translate-y-2 duration-300 shadow-lg hover:shadow-2xl">
      <img class="h-40 object-cover rounded-xl" h-40 object-cover rounded-xl" src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80" alt="">
      <div class="p-2">
        <h2 class="font-bold text-lg mb-2"><%= @item.name %></h2>
        <p class="text-sm text-gray-600">Simple Yet Beautiful Card Design with TaiwlindCss. Subscribe to our Youtube channel for more ...</p>
      </div>
    </div>
    """
  end
end
