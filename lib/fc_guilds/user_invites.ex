defmodule FcGuilds.UserInvites do
  @moduledoc """
  The UserInvites context.
  """

  import Ecto.Query, warn: false
  alias FcGuilds.Repo

  alias FcGuilds.UserInvites.UserInvite

  def accept_invite(current_user, user_invite_id) do
     # Todo: Ensure current_user.email and user_invite email are the same
    user = FcGuilds.Accounts.get_user_by_email(current_user.email) |> Repo.preload(:organizations)
    user_invite = get_user_invite!(user_invite_id)
    org = FcGuilds.Organizations.get_organization!(user_invite.organization_id)
    user_orgs = user.organizations ++ [org] |>  Enum.map(&Ecto.Changeset.change/1)
    user
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:organizations, user_orgs)
    |> Repo.update

    IO.inspect user

    user_invite
    |> UserInvite.changeset(%{status: "accepted"})
    |> Repo.update

  end

  @doc """
  Returns the list of user_invites.

  ## Examples

      iex> list_user_invites()
      [%UserInvite{}, ...]

  """
  def list_user_invites(email) do
    q = from u in UserInvite,
      where: u.email == ^email and u.status == "pending"
    Repo.all(q)
  end

  @doc """
  Gets a single user_invite.

  Raises `Ecto.NoResultsError` if the User invite does not exist.

  ## Examples

      iex> get_user_invite!(123)
      %UserInvite{}

      iex> get_user_invite!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_invite!(id), do: Repo.get!(UserInvite, id)

  @doc """
  Creates a user_invite.

  ## Examples

      iex> create_user_invite(%{field: value})
      {:ok, %UserInvite{}}

      iex> create_user_invite(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_invite(attrs \\ %{}) do
    %UserInvite{status: "pending"}
    |> UserInvite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_invite.

  ## Examples

      iex> update_user_invite(user_invite, %{field: new_value})
      {:ok, %UserInvite{}}

      iex> update_user_invite(user_invite, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_invite(%UserInvite{} = user_invite, attrs) do
    user_invite
    |> UserInvite.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_invite.

  ## Examples

      iex> delete_user_invite(user_invite)
      {:ok, %UserInvite{}}

      iex> delete_user_invite(user_invite)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_invite(%UserInvite{} = user_invite) do
    Repo.delete(user_invite)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_invite changes.

  ## Examples

      iex> change_user_invite(user_invite)
      %Ecto.Changeset{data: %UserInvite{}}

  """
  def change_user_invite(%UserInvite{} = user_invite, attrs \\ %{}) do
    UserInvite.changeset(user_invite, attrs)
  end
end
