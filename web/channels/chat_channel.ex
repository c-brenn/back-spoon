defmodule Backspoon.ChatChannel do
  use Phoenix.Channel
  require Logger

  def join("chat:" <> host, _message, socket) do
    {:ok, assign(socket, :host, host)}
  end

  def handle_in("new_message", message, socket) do
    broadcast! socket, "new_message", message
    {:noreply, socket}
  end

  intercept ["new_message"]
  def handle_out("new_message", %{"host" => host} = payload, socket) do
    if host == socket.assigns.host do
      push socket, "new_message", payload
    end
    {:noreply, socket}
  end

end
