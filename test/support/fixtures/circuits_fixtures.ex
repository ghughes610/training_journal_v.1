defmodule TrainingJournal.CircuitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TrainingJournal.Circuits` context.
  """

  @doc """
  Generate a circuit.
  """
  def circuit_fixture(attrs \\ %{}) do
    {:ok, circuit} =
      attrs
      |> Enum.into(%{
        completed: true,
        focus: "some focus",
        metadata: %{},
        name: "some name",
        rest_time: "some rest_time"
      })
      |> TrainingJournal.Circuits.create_circuit()

    circuit
  end
end
