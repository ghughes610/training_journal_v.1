defmodule TrainingJournalWeb.CircuitLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.{
    Circuits
  }

  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)
    circuits = Circuits.get_workout_circuits(id)
    socket = assign(socket, circuits: circuits, id: id)

    {:ok, socket}
  end

  def handle_event("create_circuit", params, socket) do
    data = %{
      name: "",
      completed: false,
      number_of_exercises: String.to_integer(params["number_of_exercises"]),
      sets: String.to_integer(params["sets"]),
      rest_time: params["rest_time"],
      workout_id: socket.assigns.id
    }
    with {:ok, new_circuit} <-
           Circuits.create_circuit(%{
             name: "test",
             completed: false,
             metadata: %{},


           }) do

      circuits = get_circuits(socket)
      circuits = [new_circuit | circuits]

      {:noreply, assign(socket, :circuits, circuits)}
    end
  end

  def get_circuits(socket) do
    socket.assigns.circuits
  end

end
