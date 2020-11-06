defmodule FcGuildsWeb.PageController do
  use FcGuildsWeb, :controller

  def index(conn, _params) do

    if user = conn.assigns.current_user do
      user = user |> FcGuilds.Repo.preload(:organizations)
      IO.inspect user
      render(conn, "index.html", user: user)
    else
      render(conn, "landing.html")
    end

  end
end
