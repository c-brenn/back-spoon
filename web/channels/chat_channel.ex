defmodule Backspoon.ChatChannel do
  use Phoenix.Channel
  alias Backspoon.Giphy
  require Logger

  def join("chat:" <> host, _message, socket) do
    {:ok, assign(socket, :host, host)}
  end

  def handle_in("new_message", message, socket) do
    case message["message"] do
      "/giphy " <> search_term ->
        search_term
        |> String.split
        |> Enum.join("+")
        |> Giphy.fetch_gif(socket)
      _ -> nil
    end
    broadcast! socket, "new_message", %{username: Plug.HTML.html_escape(message["username"]), message: Plug.HTML.html_escape(message["message"]), host: message["host"]}
    {:noreply, socket}
  end

  intercept ["new_message", "new_gif", "gif_not_found"]
  def handle_out(topic, %{host: host} = payload, socket) do
    if host == socket.assigns.host do
      push socket, topic, payload
    end
    {:noreply, socket}
  end

end
