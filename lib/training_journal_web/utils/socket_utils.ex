defmodule TrainingJournalWeb.Utils.SocketUtils do
  def get_socket(socket, socket_field) do
    socket<>".assigns"<>"."<>socket_field
  end
end
