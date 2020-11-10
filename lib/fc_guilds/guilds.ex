defmodule FcGuilds.Guilds do
  @moduledoc """
  The Guilds context.
  """

  import Ecto.Query, warn: false
  alias FcGuilds.Repo

  alias FcGuilds.Guilds.Guild
  alias FcGuilds.Guilds.GuildUser

  def join_guild(current_user, guild_id) do

      # Todo: Ensure current_user.email and user_invite email are the same
      user = FcGuilds.Accounts.get_user_by_email(current_user.email) |> Repo.preload(:guilds)
      guild = FcGuilds.Guilds.get_guild!(guild_id)
      user_guilds = user.guilds ++ [guild] |>  Enum.map(&Ecto.Changeset.change/1)
      user
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:guilds, user_guilds)
      |> Repo.update

  end

  def leave_guild(current_user, guild_id) do
    q = from(gu in GuildUser, where: gu.user_id == ^current_user.id and gu.guild_id == ^guild_id)
    gu = Repo.one!(q)
    Repo.delete(gu)
  end

  @doc """
  Returns the list of guilds.

  ## Examples

      iex> list_guilds()
      [%Guild{}, ...]

  """
  def list_guilds do
    Repo.all(Guild)
  end

  @doc """
  Gets a single guild.

  Raises `Ecto.NoResultsError` if the Guild does not exist.

  ## Examples

      iex> get_guild!(123)
      %Guild{}

      iex> get_guild!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guild!(id), do: Repo.get!(Guild, id)

  @doc """
  Creates a guild.

  ## Examples

      iex> create_guild(%{field: value})
      {:ok, %Guild{}}

      iex> create_guild(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guild(attrs \\ %{}) do
    %Guild{}
    |> Guild.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guild.

  ## Examples

      iex> update_guild(guild, %{field: new_value})
      {:ok, %Guild{}}

      iex> update_guild(guild, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guild(%Guild{} = guild, attrs) do
    guild
    |> Guild.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guild.

  ## Examples

      iex> delete_guild(guild)
      {:ok, %Guild{}}

      iex> delete_guild(guild)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guild(%Guild{} = guild) do
    Repo.delete(guild)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guild changes.

  ## Examples

      iex> change_guild(guild)
      %Ecto.Changeset{data: %Guild{}}

  """
  def change_guild(%Guild{} = guild, attrs \\ %{}) do
    Guild.changeset(guild, attrs)
  end
end
