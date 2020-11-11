defmodule FcGuildsWeb.UserInviteController do
  use FcGuildsWeb, :controller

  alias FcGuilds.UserInvites
  alias FcGuilds.UserInvites.UserInvite
  alias FcGuilds.Repo

  def index(conn, _params) do
    user = conn.assigns.current_user
    user_invites = UserInvites.list_user_invites(user.email) |> Repo.preload(:organization)
    IO.inspect(user_invites)
    render(conn, "index.html", user_invites: user_invites)
  end

  def new(conn, %{"organization_id" => org_id}) do
    changeset = UserInvites.change_user_invite(%UserInvite{}, %{organization_id: org_id})
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_invite" => user_invite_params}) do
    IO.inspect(user_invite_params)

    case UserInvites.create_user_invite(user_invite_params) do
      {:ok, user_invite} ->
        conn
        |> put_flash(:info, "User invite created successfully.")
        |> redirect(to: Routes.user_invite_path(conn, :show, user_invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def accept(conn, %{"user_invite_id" => user_invite_id}) do
    IO.inspect(user_invite_id)
    user_invite = UserInvites.get_user_invite!(user_invite_id)

    case UserInvites.accept_invite(conn.assigns.current_user, user_invite_id) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User invite updated successfully.")
        |> redirect(
          to:
            Routes.organization_path(conn, :guilds, organization_id: user_invite.organization_id)
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        user_invites =
          UserInvites.list_user_invites(conn.assigns.current_user.email)
          |> Repo.preload(:organization)

        render(conn, "index.html", user_invites: user_invites)
    end
  end

  def show(conn, %{"id" => id}) do
    user_invite = UserInvites.get_user_invite!(id)
    render(conn, "show.html", user_invite: user_invite)
  end

  def edit(conn, %{"id" => id}) do
    user_invite = UserInvites.get_user_invite!(id)
    changeset = UserInvites.change_user_invite(user_invite)
    render(conn, "edit.html", user_invite: user_invite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_invite" => user_invite_params}) do
    user_invite = UserInvites.get_user_invite!(id)

    case UserInvites.update_user_invite(user_invite, user_invite_params) do
      {:ok, user_invite} ->
        conn
        |> put_flash(:info, "User invite updated successfully.")
        |> redirect(to: Routes.user_invite_path(conn, :show, user_invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_invite: user_invite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_invite = UserInvites.get_user_invite!(id)
    {:ok, _user_invite} = UserInvites.delete_user_invite(user_invite)

    conn
    |> put_flash(:info, "User invite deleted successfully.")
    |> redirect(to: Routes.user_invite_path(conn, :index))
  end
end
