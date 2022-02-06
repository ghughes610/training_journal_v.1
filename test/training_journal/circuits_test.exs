defmodule TrainingJournal.CircuitsTest do
  use TrainingJournal.DataCase

  alias TrainingJournal.Circuits

  describe "circuits" do
    alias TrainingJournal.Circuits.Circuit

    import TrainingJournal.CircuitsFixtures

    @invalid_attrs %{}

    test "list_circuits/0 returns all circuits" do
      circuit = circuit_fixture()
      assert Circuits.list_circuits() == [circuit]
    end

    test "get_circuit!/1 returns the circuit with given id" do
      circuit = circuit_fixture()
      assert Circuits.get_circuit!(circuit.id) == circuit
    end

    test "create_circuit/1 with valid data creates a circuit" do
      valid_attrs = %{}

      assert {:ok, %Circuit{} = circuit} = Circuits.create_circuit(valid_attrs)
    end

    test "create_circuit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Circuits.create_circuit(@invalid_attrs)
    end

    test "update_circuit/2 with valid data updates the circuit" do
      circuit = circuit_fixture()
      update_attrs = %{}

      assert {:ok, %Circuit{} = circuit} = Circuits.update_circuit(circuit, update_attrs)
    end

    test "update_circuit/2 with invalid data returns error changeset" do
      circuit = circuit_fixture()
      assert {:error, %Ecto.Changeset{}} = Circuits.update_circuit(circuit, @invalid_attrs)
      assert circuit == Circuits.get_circuit!(circuit.id)
    end

    test "delete_circuit/1 deletes the circuit" do
      circuit = circuit_fixture()
      assert {:ok, %Circuit{}} = Circuits.delete_circuit(circuit)
      assert_raise Ecto.NoResultsError, fn -> Circuits.get_circuit!(circuit.id) end
    end

    test "change_circuit/1 returns a circuit changeset" do
      circuit = circuit_fixture()
      assert %Ecto.Changeset{} = Circuits.change_circuit(circuit)
    end
  end
end
