defmodule FcGuilds.Repo.Migrations.CreateUserInvites do
  use Ecto.Migration

  def change do
    create table(:user_invites) do
      add :email, :string
      add :status, :string
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:user_invites, [:organization_id])
  end
end
