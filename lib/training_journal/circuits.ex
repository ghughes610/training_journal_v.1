defmodule TrainingJournal.Circuits do
  @moduledoc """
  The Circuits context.
  """

  import Ecto.Query, warn: false
  alias TrainingJournal.Repo

  alias TrainingJournal.Circuits.Circuit

  import Ecto.Query

  @doc """
  Returns the list of circuits.

  ## Examples

      iex> list_circuits()
      [%Circuit{}, ...]

  """
  def list_circuits do
    Repo.all(Circuit)
  end

  @doc """
  Gets a single circuit.

  Raises `Ecto.NoResultsError` if the Circuit does not exist.

  ## Examples

      iex> get_circuit!(123)
      %Circuit{}

      iex> get_circuit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_circuit!(id), do: Repo.get!(Circuit, id)


  def get_workout_circuits(workout_id) do
      list_circuits()
      |> Enum.filter(&(&1.workout_id == workout_id))
  end

  @doc """
  Creates a circuit.

  ## Examples

      iex> create_circuit(%{field: value})
      {:ok, %Circuit{}}

      iex> create_circuit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_circuit(attrs \\ %{}) do
    %Circuit{}
    |> Circuit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a circuit.

  ## Examples

      iex> update_circuit(circuit, %{field: new_value})
      {:ok, %Circuit{}}

      iex> update_circuit(circuit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_circuit(%Circuit{} = circuit, attrs) do
    circuit
    |> Circuit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a circuit.

  ## Examples

      iex> delete_circuit(circuit)
      {:ok, %Circuit{}}

      iex> delete_circuit(circuit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_circuit(%Circuit{} = circuit) do
    Repo.delete(circuit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking circuit changes.

  ## Examples

      iex> change_circuit(circuit)
      %Ecto.Changeset{data: %Circuit{}}

  """
  def change_circuit(%Circuit{} = circuit, attrs \\ %{}) do
    Circuit.changeset(circuit, attrs)
  end
end
