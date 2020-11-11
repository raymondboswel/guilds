defmodule FcGuilds.Guilds.GuildUser do
  @moduledoc """
  Schema to manage guild users
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias FcGuilds.Accounts.User
  alias FcGuilds.Guilds.Guild
  @already_exists "ALREADY_EXISTS"

  @primary_key false

  schema "guild_users" do
    belongs_to(:user, User, primary_key: true)
    belongs_to(:guild, Guild, primary_key: true)
    timestamps()
  end

  @required_fields ~w(user_id guild_id)a
  def changeset(guild_user, params \\ %{}) do
    guild_user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:guild_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:user, :guild],
      name: :user_id_guild_id_unique_index,
      message: @already_exists
    )
  end
end
