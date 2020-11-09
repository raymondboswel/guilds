defmodule FcGuilds.GuildEvents do
  @moduledoc """
  The GuildEvents context.
  """

  import Ecto.Query, warn: false
  alias FcGuilds.Repo

  alias FcGuilds.GuildEvents.GuildEvent

  @doc """
  Returns the list of guild_events.

  ## Examples

      iex> list_guild_events()
      [%GuildEvent{}, ...]

  """
  def list_guild_events(guild_id) do
    q = from g in GuildEvent,
      where: g.guild_id == ^guild_id

    Repo.all(q)
  end

  @doc """
  Gets a single guild_event.

  Raises `Ecto.NoResultsError` if the Guild event does not exist.

  ## Examples

      iex> get_guild_event!(123)
      %GuildEvent{}

      iex> get_guild_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guild_event!(id), do: Repo.get!(GuildEvent, id)

  @doc """
  Creates a guild_event.

  ## Examples

      iex> create_guild_event(%{field: value})
      {:ok, %GuildEvent{}}

      iex> create_guild_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guild_event(attrs \\ %{}) do
    %GuildEvent{}
    |> GuildEvent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guild_event.

  ## Examples

      iex> update_guild_event(guild_event, %{field: new_value})
      {:ok, %GuildEvent{}}

      iex> update_guild_event(guild_event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guild_event(%GuildEvent{} = guild_event, attrs) do
    guild_event
    |> GuildEvent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guild_event.

  ## Examples

      iex> delete_guild_event(guild_event)
      {:ok, %GuildEvent{}}

      iex> delete_guild_event(guild_event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guild_event(%GuildEvent{} = guild_event) do
    Repo.delete(guild_event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guild_event changes.

  ## Examples

      iex> change_guild_event(guild_event)
      %Ecto.Changeset{data: %GuildEvent{}}

  """
  def change_guild_event(%GuildEvent{} = guild_event, attrs \\ %{}) do
    GuildEvent.changeset(guild_event, attrs)
  end
end
