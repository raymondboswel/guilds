defmodule FcGuildsWeb.GuildEventController do
  use FcGuildsWeb, :controller

  alias FcGuilds.Guilds
  alias FcGuilds.GuildEvents
  alias FcGuilds.GuildEvents.GuildEvent
  alias FcGuilds.Repo

  def index(conn, %{"guild_id" => guild_id }) do
    guild = Guilds.get_guild!(guild_id)
    guild_events = GuildEvents.list_guild_events(guild_id) |> Repo.preload(:user)
    render(conn, "index.html", guild_events: guild_events, guild_id: guild_id, guild: guild)
  end

  def new(conn, %{"guild_id" => guild_id}) do

    user = conn.assigns.current_user
    guild = Guilds.get_guild!(guild_id) |> Repo.preload(:users)
    changeset = GuildEvents.change_guild_event(%GuildEvent{}, %{guild_id: guild_id, user_id: user.id})
    render(conn, "new.html", changeset: changeset, guild: guild)
   end

  def assign_events(conn, f=  %{"guild_id" => guild_id}) do
    render(conn, "assign.html", guild_id: guild_id)
  end

  def generate_assigned_events(conn, f = %{"form" => %{"start_date" => start_date,"frequency" => frequency, "count" => count, "guild_id" => guild_id}}) do

    {:ok, datetime, 0} = DateTime.from_iso8601("#{start_date}T12:00:00Z")
    GuildEvents.assign_guild_events(guild_id, String.to_integer(count), frequency, datetime)
    redirect(conn, to: Routes.guild_event_path(conn, :index, guild_id: guild_id))
  end

  def create(conn, %{"guild_event" => guild_event_params}) do
    IO.inspect(guild_event_params)
    case GuildEvents.create_guild_event(guild_event_params) do
      {:ok, guild_event} ->
        conn
        |> put_flash(:info, "Guild event created successfully.")
        |> redirect(to: Routes.guild_event_path(conn, :show, guild_event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    guild_event = GuildEvents.get_guild_event!(id)
    render(conn, "show.html", guild_event: guild_event)
  end

  def edit(conn, %{"id" => id}) do
    guild_event = GuildEvents.get_guild_event!(id) |> Repo.preload(:user)
    changeset = GuildEvents.change_guild_event(guild_event)
    guild = Guilds.get_guild!(guild_event.guild_id) |> Repo.preload(:users)
    users = Enum.map(guild.users, fn u -> {String.to_atom(u.email), u.id} end)
    IO.inspect users
    IO.inspect guild_event
    render(conn, "edit.html", guild: guild, guild_event: guild_event, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "guild_event" => guild_event_params} = f) do
    IO.inspect "Hitting update"
    IO.inspect f
    guild_event = GuildEvents.get_guild_event!(id)

    case GuildEvents.update_guild_event(guild_event, guild_event_params) do
      {:ok, guild_event} ->
        conn
        |> put_flash(:info, "Guild event updated successfully.")
        |> redirect(to: Routes.guild_event_path(conn, :show, guild_event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", guild_event: guild_event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    guild_event = GuildEvents.get_guild_event!(id)
    {:ok, _guild_event} = GuildEvents.delete_guild_event(guild_event)

    conn
    |> put_flash(:info, "Guild event deleted successfully.")
    |> redirect(to: Routes.guild_event_path(conn, :index, guild_id: guild_event.guild_id))
  end
end
