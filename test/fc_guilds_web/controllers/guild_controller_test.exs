defmodule FcGuildsWeb.GuildControllerTest do
  use FcGuildsWeb.ConnCase

  alias FcGuilds.Guilds

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:guild) do
    {:ok, guild} = Guilds.create_guild(@create_attrs)
    guild
  end

  describe "index" do
    test "lists all guilds", %{conn: conn} do
      conn = get(conn, Routes.guild_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Guilds"
    end
  end

  describe "new guild" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.guild_path(conn, :new))
      assert html_response(conn, 200) =~ "New Guild"
    end
  end

  describe "create guild" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.guild_path(conn, :create), guild: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.guild_path(conn, :show, id)

      conn = get(conn, Routes.guild_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Guild"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.guild_path(conn, :create), guild: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Guild"
    end
  end

  describe "edit guild" do
    setup [:create_guild]

    test "renders form for editing chosen guild", %{conn: conn, guild: guild} do
      conn = get(conn, Routes.guild_path(conn, :edit, guild))
      assert html_response(conn, 200) =~ "Edit Guild"
    end
  end

  describe "update guild" do
    setup [:create_guild]

    test "redirects when data is valid", %{conn: conn, guild: guild} do
      conn = put(conn, Routes.guild_path(conn, :update, guild), guild: @update_attrs)
      assert redirected_to(conn) == Routes.guild_path(conn, :show, guild)

      conn = get(conn, Routes.guild_path(conn, :show, guild))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, guild: guild} do
      conn = put(conn, Routes.guild_path(conn, :update, guild), guild: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Guild"
    end
  end

  describe "delete guild" do
    setup [:create_guild]

    test "deletes chosen guild", %{conn: conn, guild: guild} do
      conn = delete(conn, Routes.guild_path(conn, :delete, guild))
      assert redirected_to(conn) == Routes.guild_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.guild_path(conn, :show, guild))
      end
    end
  end

  defp create_guild(_) do
    guild = fixture(:guild)
    %{guild: guild}
  end
end
