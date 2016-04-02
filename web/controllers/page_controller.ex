defmodule Backspoon.PageController do
  use Backspoon.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
