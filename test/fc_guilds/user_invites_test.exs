defmodule FcGuilds.UserInvitesTest do
  use FcGuilds.DataCase

  alias FcGuilds.UserInvites

  describe "user_invites" do
    alias FcGuilds.UserInvites.UserInvite

    @valid_attrs %{email: "some email", status: "some status"}
    @update_attrs %{email: "some updated email", status: "some updated status"}
    @invalid_attrs %{email: nil, status: nil}

    def user_invite_fixture(attrs \\ %{}) do
      {:ok, user_invite} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserInvites.create_user_invite()

      user_invite
    end

    test "list_user_invites/0 returns all user_invites" do
      user_invite = user_invite_fixture()
      assert UserInvites.list_user_invites() == [user_invite]
    end

    test "get_user_invite!/1 returns the user_invite with given id" do
      user_invite = user_invite_fixture()
      assert UserInvites.get_user_invite!(user_invite.id) == user_invite
    end

    test "create_user_invite/1 with valid data creates a user_invite" do
      assert {:ok, %UserInvite{} = user_invite} = UserInvites.create_user_invite(@valid_attrs)
      assert user_invite.email == "some email"
      assert user_invite.status == "some status"
    end

    test "create_user_invite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserInvites.create_user_invite(@invalid_attrs)
    end

    test "update_user_invite/2 with valid data updates the user_invite" do
      user_invite = user_invite_fixture()
      assert {:ok, %UserInvite{} = user_invite} = UserInvites.update_user_invite(user_invite, @update_attrs)
      assert user_invite.email == "some updated email"
      assert user_invite.status == "some updated status"
    end

    test "update_user_invite/2 with invalid data returns error changeset" do
      user_invite = user_invite_fixture()
      assert {:error, %Ecto.Changeset{}} = UserInvites.update_user_invite(user_invite, @invalid_attrs)
      assert user_invite == UserInvites.get_user_invite!(user_invite.id)
    end

    test "delete_user_invite/1 deletes the user_invite" do
      user_invite = user_invite_fixture()
      assert {:ok, %UserInvite{}} = UserInvites.delete_user_invite(user_invite)
      assert_raise Ecto.NoResultsError, fn -> UserInvites.get_user_invite!(user_invite.id) end
    end

    test "change_user_invite/1 returns a user_invite changeset" do
      user_invite = user_invite_fixture()
      assert %Ecto.Changeset{} = UserInvites.change_user_invite(user_invite)
    end
  end
end
