defmodule FcGuilds.Repo.Migrations.AddOrganizationUsers do
  use Ecto.Migration

  def change do
    create table(:organization_users, primary_key: false) do
      add(:organization_id, references(:organizations, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:organization_users, [:organization_id]))
    create(index(:organization_users, [:user_id]))

    create(
      unique_index(:organization_users, [:user_id, :organization_id],
        name: :user_id_organization_id_unique_index
      )
    )
  end
end
