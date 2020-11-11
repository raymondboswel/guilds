defmodule FcGuilds.Repo.Migrations.CreateGuildUsers do
  use Ecto.Migration

  def change do
    create table(:guild_users, primary_key: false) do
      add(:guild_id, references(:guilds, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:guild_users, [:guild_id]))
    create(index(:guild_users, [:user_id]))

    create(
      unique_index(:guild_users, [:user_id, :guild_id], name: :user_id_guild_id_unique_index)
    )
  end
end
