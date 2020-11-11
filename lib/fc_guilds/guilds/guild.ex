defmodule FcGuilds.Guilds.Guild do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guilds" do
    field :name, :string
    field :organization_id, :id

    many_to_many(
      :users,
      FcGuilds.Accounts.User,
      join_through: FcGuilds.Guilds.GuildUser,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(guild, attrs) do
    guild
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name ])
  end
end
