defmodule TrainingJournal.WorkoutsTest do
  use TrainingJournal.DataCase

  alias TrainingJournal.Workouts

  describe "workouts" do
    alias TrainingJournal.Workouts.Workout

    import TrainingJournal.WorkoutsFixtures

    @invalid_attrs %{completed: nil, cross_training: nil, date: nil, finger_training: nil, name: nil, type: nil}

    test "list_workouts/0 returns all workouts" do
      workout = workout_fixture()
      assert Workouts.list_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Workouts.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      valid_attrs = %{completed: true, cross_training: true, date: ~U[2022-02-05 02:51:00Z], finger_training: true, name: "some name", type: "some type"}

      assert {:ok, %Workout{} = workout} = Workouts.create_workout(valid_attrs)
      assert workout.completed == true
      assert workout.cross_training == true
      assert workout.date == ~U[2022-02-05 02:51:00Z]
      assert workout.finger_training == true
      assert workout.name == "some name"
      assert workout.type == "some type"
    end

    test "create_workout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workouts.create_workout(@invalid_attrs)
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()
      update_attrs = %{completed: false, cross_training: false, date: ~U[2022-02-06 02:51:00Z], finger_training: false, name: "some updated name", type: "some updated type"}

      assert {:ok, %Workout{} = workout} = Workouts.update_workout(workout, update_attrs)
      assert workout.completed == false
      assert workout.cross_training == false
      assert workout.date == ~U[2022-02-06 02:51:00Z]
      assert workout.finger_training == false
      assert workout.name == "some updated name"
      assert workout.type == "some updated type"
    end

    test "update_workout/2 with invalid data returns error changeset" do
      workout = workout_fixture()
      assert {:error, %Ecto.Changeset{}} = Workouts.update_workout(workout, @invalid_attrs)
      assert workout == Workouts.get_workout!(workout.id)
    end

    test "delete_workout/1 deletes the workout" do
      workout = workout_fixture()
      assert {:ok, %Workout{}} = Workouts.delete_workout(workout)
      assert_raise Ecto.NoResultsError, fn -> Workouts.get_workout!(workout.id) end
    end

    test "change_workout/1 returns a workout changeset" do
      workout = workout_fixture()
      assert %Ecto.Changeset{} = Workouts.change_workout(workout)
    end
  end
end
