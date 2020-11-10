defmodule FcGuildsWeb.PageController do
  use FcGuildsWeb, :controller

  def index(conn, _params) do

    if user = conn.assigns.current_user do
      user = user |> FcGuilds.Repo.preload([:organizations])
      invitations = FcGuilds.UserInvites.list_user_invites(user.email)
      IO.inspect user
      render(conn, "index.html", user: user, invitations: invitations)
    else
      render(conn, "landing.html")
    end

  end
end
