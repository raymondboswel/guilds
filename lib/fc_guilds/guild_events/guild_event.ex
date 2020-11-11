defmodule FcGuilds.GuildEvents.GuildEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guild_events" do
    field :duration, :integer
    field :event_date, :utc_datetime
    field :title, :string
    belongs_to(:user, FcGuilds.Accounts.User )
    field :guild_id, :id

    timestamps()
  end

  @doc false
  def changeset(guild_event, attrs) do
    guild_event
    |> cast(attrs, [:title, :event_date, :duration, :guild_id, :user_id])
    |> validate_required([:title, :event_date, :duration])
  end
end
