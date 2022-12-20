defmodule TrainingJournalWeb.CreateWorkoutLiveTest do
  use TrainingJournalWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "creating workout" do
    test "am workout? exact same time" do
      assert TrainingJournalWeb.CreateWorkoutLive.am_workout?(Timex.set(Timex.now(), [hour: 12])) == true
    end

    test "am workout? am time" do
      assert TrainingJournalWeb.CreateWorkoutLive.am_workout?(Timex.set(Timex.now(), [hour: 8])) == false
    end

    test "am workout? exact pm time" do
      assert TrainingJournalWeb.CreateWorkoutLive.am_workout?(Timex.set(Timex.now(), [hour: 20])) == true
    end
  end
end
