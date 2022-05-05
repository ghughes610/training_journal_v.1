defmodule TrainingJournalWeb.CircuitLive do
  use TrainingJournalWeb, :live_view

  alias TrainingJournal.Circuits
  alias TrainingJournal.Repo

  import Ecto.Query



  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)

    circuits = Circuits.get_workout_circuits(id)

    socket = assign(socket, circuits: circuits, id: id)
    {:ok, socket}

  end

  def handle_event(
        "create_circuit",
        %{"name" => name, "focus" => focus, "metadata" => metadata, "sets" => sets},
        socket
      ) do

    metadata =
      metadata
      |> JSON.decode()
      |> elem(1)

    with {:ok, new_circuit} <-
           Circuits.create_circuit(%{
             name: name,
             focus: focus,
             completed: false,
             metadata: metadata,
             workout_id: socket.assigns.id
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
