defmodule TrainingJournalWeb.FullWorkoutLive do
  use TrainingJournalWeb, :live_view
  def mount(%{"id" => id}, _session, socket) do
    IO.puts("id below")
    IO.inspect(id)
    socket = assign(socket, key: "value")
    {:ok, socket}
  end
end
