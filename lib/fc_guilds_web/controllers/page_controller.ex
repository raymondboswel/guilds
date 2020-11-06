defmodule FcGuildsWeb.PageController do
  use FcGuildsWeb, :controller

  def index(conn, _params) do
    IO.inspect conn
    if user = conn.assigns.current_user do

      render(conn, "index.html", user: conn.assigns.current_user)
    else
      render(conn, "landing.html")
    end

  end
end
