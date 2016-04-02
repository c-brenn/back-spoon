defmodule Backspoon.ChatChannel do
  use Phoenix.Channel
  require Logger

  def join("chat:" <> host, _message, socket) do
    Logger.info("[User Joined]: #{host}")
    {:ok, assign(socket, :host, host)}
  end

  def handle_in("new_message", %{"host" => host}, socket) do
    broadcast! socket, "new_message", %{username: "spoon", message: "older woman", host: host}
    {:noreply, socket}
  end

  intercept ["new_message"]
  def handle_out("new_message", %{host: host} = payload, socket) do
    if host == socket.assigns.host do
      Logger.info("message: #{host} socket: #{socket.assigns.host}")
      push socket, "new_message", payload
    end
    {:noreply, socket}
  end

end
