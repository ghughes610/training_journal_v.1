defmodule TrainingJournalWeb.ChartLive do
  use TrainingJournalWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, data: "there will be data here")

    {:ok, socket}
  end
end
