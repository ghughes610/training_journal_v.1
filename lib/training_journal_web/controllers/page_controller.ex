defmodule TrainingJournalWeb.PageController do
  use TrainingJournalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
