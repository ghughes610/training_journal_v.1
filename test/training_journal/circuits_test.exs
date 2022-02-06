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

  describe "circuits" do
    alias TrainingJournal.Circuits.Circuit

    import TrainingJournal.CircuitsFixtures

    @invalid_attrs %{completed: nil, focus: nil, metadata: nil, name: nil, rest_time: nil}

    test "list_circuits/0 returns all circuits" do
      circuit = circuit_fixture()
      assert Circuits.list_circuits() == [circuit]
    end

    test "get_circuit!/1 returns the circuit with given id" do
      circuit = circuit_fixture()
      assert Circuits.get_circuit!(circuit.id) == circuit
    end

    test "create_circuit/1 with valid data creates a circuit" do
      valid_attrs = %{completed: true, focus: "some focus", metadata: %{}, name: "some name", rest_time: "some rest_time"}

      assert {:ok, %Circuit{} = circuit} = Circuits.create_circuit(valid_attrs)
      assert circuit.completed == true
      assert circuit.focus == "some focus"
      assert circuit.metadata == %{}
      assert circuit.name == "some name"
      assert circuit.rest_time == "some rest_time"
    end

    test "create_circuit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Circuits.create_circuit(@invalid_attrs)
    end

    test "update_circuit/2 with valid data updates the circuit" do
      circuit = circuit_fixture()
      update_attrs = %{completed: false, focus: "some updated focus", metadata: %{}, name: "some updated name", rest_time: "some updated rest_time"}

      assert {:ok, %Circuit{} = circuit} = Circuits.update_circuit(circuit, update_attrs)
      assert circuit.completed == false
      assert circuit.focus == "some updated focus"
      assert circuit.metadata == %{}
      assert circuit.name == "some updated name"
      assert circuit.rest_time == "some updated rest_time"
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
