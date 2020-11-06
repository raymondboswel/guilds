defmodule FcGuildsWeb.PageController do
  use FcGuildsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
