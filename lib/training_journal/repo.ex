defmodule TrainingJournal.Repo do
  use Ecto.Repo,
    otp_app: :training_journal,
    adapter: Ecto.Adapters.Postgres
end
