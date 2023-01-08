defmodule TrainingJournalWeb.WhiteboardLive do
  use TrainingJournalWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, key: "value")
    {:ok, socket}
  end
end
