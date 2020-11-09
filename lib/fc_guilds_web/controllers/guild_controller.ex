defmodule FcGuildsWeb.GuildController do
  use FcGuildsWeb, :controller

  alias FcGuilds.Guilds
  alias FcGuilds.Guilds.Guild

  def index(conn, _params) do
    guilds = Guilds.list_guilds()
    render(conn, "index.html", guilds: guilds)
  end

  def new(conn, %{"organization_id" => org_id}) do
    changeset = Guilds.change_guild(%Guild{}, %{organization_id: org_id})
    IO.inspect changeset
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"guild" => guild_params}) do
    IO.inspect(guild_params)
    case Guilds.create_guild(guild_params) do
      {:ok, guild} ->
        conn
        |> put_flash(:info, "Guild created successfully.")
        |> redirect(to: Routes.guild_path(conn, :show, guild))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    guild = Guilds.get_guild!(id)
    render(conn, "show.html", guild: guild)
  end

  def edit(conn, %{"id" => id}) do
    guild = Guilds.get_guild!(id)
    changeset = Guilds.change_guild(guild)
    render(conn, "edit.html", guild: guild, changeset: changeset)
  end

  def update(conn, %{"id" => id, "guild" => guild_params}) do
    guild = Guilds.get_guild!(id)

    case Guilds.update_guild(guild, guild_params) do
      {:ok, guild} ->
        conn
        |> put_flash(:info, "Guild updated successfully.")
        |> redirect(to: Routes.guild_path(conn, :show, guild))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", guild: guild, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    guild = Guilds.get_guild!(id)
    {:ok, _guild} = Guilds.delete_guild(guild)

    conn
    |> put_flash(:info, "Guild deleted successfully.")
    |> redirect(to: Routes.guild_path(conn, :index))
  end
end
