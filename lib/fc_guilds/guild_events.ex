defmodule FcGuilds.GuildEvents do
  @moduledoc """
  The GuildEvents context.
  """

  import Ecto.Query, warn: false
  alias FcGuilds.Repo

  alias FcGuilds.GuildEvents.GuildEvent
  alias FcGuilds.Guilds

  # Get frequency of users events as % and invert to get ideal distribution
  # of assignments in next batch of events. Load array of users, with a
  # max of 20 copies of a user if the user has had no previous guild events,
  # then randomly select users from the list to assign guilds. This will
  # give a higher probability of choosing a user that has presented fewer guilds

  # TODO: Currently users aren't associated with guilds, so I can't include users
  # with no guild events. Once the full members list is available, add a full 20
  # instances of the new user to the list
  def assign_guild_events(guild_id) do
    #guild = Guilds.get_guild!(guild_id) |> Repo.preload(:users)
    #users = guild.users
    guild_events = list_guild_events(guild_id)
    user_guild_events = Enum.group_by(guild_events, fn ge -> ge.user_id end)
    user_guild_events_proportions =
      Enum.map(user_guild_events,
        fn({k, v}) ->
          {k, 1 - length(v) / length(guild_events) } end)
    frequency_list = user_guild_events_proportions
    |> Enum.map(fn ugep ->
      {user_id, proportion} = ugep
      count = floor(20 * proportion)
      for n <- 1..count, do: user_id
    end)
    |> Enum.concat

    guild_assignees = Enum.take_random(frequency_list, 5)

  end

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
