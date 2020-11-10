defmodule FcGuildsWeb.UserInviteControllerTest do
  use FcGuildsWeb.ConnCase

  alias FcGuilds.UserInvites

  @create_attrs %{email: "some email", status: "some status"}
  @update_attrs %{email: "some updated email", status: "some updated status"}
  @invalid_attrs %{email: nil, status: nil}

  def fixture(:user_invite) do
    {:ok, user_invite} = UserInvites.create_user_invite(@create_attrs)
    user_invite
  end

  describe "index" do
    test "lists all user_invites", %{conn: conn} do
      conn = get(conn, Routes.user_invite_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User invites"
    end
  end

  describe "new user_invite" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_invite_path(conn, :new))
      assert html_response(conn, 200) =~ "New User invite"
    end
  end

  describe "create user_invite" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_invite_path(conn, :create), user_invite: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_invite_path(conn, :show, id)

      conn = get(conn, Routes.user_invite_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User invite"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_invite_path(conn, :create), user_invite: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User invite"
    end
  end

  describe "edit user_invite" do
    setup [:create_user_invite]

    test "renders form for editing chosen user_invite", %{conn: conn, user_invite: user_invite} do
      conn = get(conn, Routes.user_invite_path(conn, :edit, user_invite))
      assert html_response(conn, 200) =~ "Edit User invite"
    end
  end

  describe "update user_invite" do
    setup [:create_user_invite]

    test "redirects when data is valid", %{conn: conn, user_invite: user_invite} do
      conn = put(conn, Routes.user_invite_path(conn, :update, user_invite), user_invite: @update_attrs)
      assert redirected_to(conn) == Routes.user_invite_path(conn, :show, user_invite)

      conn = get(conn, Routes.user_invite_path(conn, :show, user_invite))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, user_invite: user_invite} do
      conn = put(conn, Routes.user_invite_path(conn, :update, user_invite), user_invite: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User invite"
    end
  end

  describe "delete user_invite" do
    setup [:create_user_invite]

    test "deletes chosen user_invite", %{conn: conn, user_invite: user_invite} do
      conn = delete(conn, Routes.user_invite_path(conn, :delete, user_invite))
      assert redirected_to(conn) == Routes.user_invite_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_invite_path(conn, :show, user_invite))
      end
    end
  end

  defp create_user_invite(_) do
    user_invite = fixture(:user_invite)
    %{user_invite: user_invite}
  end
end
