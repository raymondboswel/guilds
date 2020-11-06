defmodule FcGuilds.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias FcGuilds.Accounts.User

  schema "organizations" do
    field :name, :string

    many_to_many(
      :users,
      User,
      join_through: FcGuilds.Organizations.OrganizationUser,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
