defmodule FcGuilds.Organizations.OrganizationUser do
  @moduledoc """
  Schema to manage organization users
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias FcGuilds.Accounts.User
  alias FcGuilds.Organizations.Organization
  @already_exists "ALREADY_EXISTS"

  @primary_key false

  schema "organization_users" do
    belongs_to(:user, User, primary_key: true)
    belongs_to(:organization, Organization, primary_key: true)
    timestamps()
  end

 @required_fields ~w(user_id organization_id)a
  def changeset(organization_user, params \\ %{}) do
   organization_user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:organization_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:user, :organization],
      name: :user_id_organization_id_unique_index,
      message: @already_exists
    )
  end
end
