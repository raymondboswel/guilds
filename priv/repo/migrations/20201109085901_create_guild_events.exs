defmodule FcGuilds.Repo.Migrations.CreateGuildEvents do
  use Ecto.Migration

  def change do
    create table(:guild_events) do
      add :title, :string
      add :event_date, :utc_datetime
      add :duration, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :guild_id, references(:guilds, on_delete: :nothing)

      timestamps()
    end

    create index(:guild_events, [:user_id])
    create index(:guild_events, [:guild_id])
  end
end
