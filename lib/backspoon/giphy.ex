defmodule Backspoon.Giphy do
  alias Backspoon.Endpoint
  require Logger
  @search_url "http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC&limit=1"

  def fetch_gif("", _), do: {:error, :no_search_term}
  def fetch_gif(search_term, socket) when is_binary(search_term) do
    Logger.info("Starting giphy #{search_term}")
    Task.Supervisor.start_child(
      Backspoon.GiphySupervisor,
      fn ->
        case HTTPoison.get(@search_url <> "&q=" <> search_term) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            b = body |> Poison.decode!
            case b["data"] do
              [h|_] ->
                Logger.info("Good giphy #{search_term}")
                Endpoint.broadcast! "chat:" <> socket.assigns.host, "new_gif", %{url: h["images"]["original"]["url"], host: socket.assigns.host}
              _ ->
                Logger.info("Bad giphy #{search_term}")
                Endpoint.broadcast! "chat:" <> socket.assigns.host, "gif_not_found", %{host: socket.assigns.host, term: search_term |> String.split("+") |> Enum.join(" ")}
            end
          _ ->
            Endpoint.broadcast! "chat:" <> socket.assigns.host, "gif_not_found", %{host: socket.assigns.host, term: search_term |> String.split("+") |> Enum.join(" ")}
            {:error, :no_gif}
        end
      end
    )
  end
  def fetch_gif(_, _), do: {:error, :invalid_search_term}
end
