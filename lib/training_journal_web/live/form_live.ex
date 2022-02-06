defmodule TrainingJournalWeb.Live do
  use TrainingJournalWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, name: "")
    {:ok, socket}
  end

  def render(assigns) do
  ~L"""
    <div>
        <label for="price" class="block text-sm font-medium text-gray-700">Price</label>
        <div class="mt-1 relative rounded-md shadow-sm">
        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <span class="text-gray-500 sm:text-sm"> $ </span>
        </div>
        <input type="text" name="price" id="price" class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md" placeholder="0.00">
        </div>
    </div>
    """
  end
end
