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

      })
      |> TrainingJournal.Circuits.create_circuit()

    circuit
  end
end
