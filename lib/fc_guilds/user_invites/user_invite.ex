defmodule FcGuilds.UserInvites.UserInvite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_invites" do
    field :email, :string
    field :status, :string
    belongs_to(:organization, FcGuilds.Organizations.Organization)

    timestamps()
  end

  @doc false
  def changeset(user_invite, attrs) do
    user_invite
    |> cast(attrs, [:email, :status, :organization_id])
    |> validate_required([:email])
  end
end
