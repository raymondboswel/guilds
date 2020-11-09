defmodule FcGuilds.Guilds.Guild do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guilds" do
    field :name, :string
    field :organization_id, :id

    timestamps()
  end

  @doc false
  def changeset(guild, attrs) do
    guild
    |> cast(attrs, [:name, :organization_id])
    |> validate_required([:name ])
  end
end
