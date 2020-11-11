defmodule FcGuildsWeb.GuildEventControllerTest do
  use FcGuildsWeb.ConnCase

  alias FcGuilds.GuildEvents

  @create_attrs %{duration: 42, event_date: "2010-04-17T14:00:00Z", title: "some title"}
  @update_attrs %{duration: 43, event_date: "2011-05-18T15:01:01Z", title: "some updated title"}
  @invalid_attrs %{duration: nil, event_date: nil, title: nil}

  def fixture(:guild_event) do
    {:ok, guild_event} = GuildEvents.create_guild_event(@create_attrs)
    guild_event
  end

  describe "index" do
    test "lists all guild_events", %{conn: conn} do
      conn = get(conn, Routes.guild_event_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Guild events"
    end
  end

  describe "new guild_event" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.guild_event_path(conn, :new))
      assert html_response(conn, 200) =~ "New Guild event"
    end
  end

  describe "create guild_event" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.guild_event_path(conn, :create), guild_event: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.guild_event_path(conn, :show, id)

      conn = get(conn, Routes.guild_event_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Guild event"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.guild_event_path(conn, :create), guild_event: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Guild event"
    end
  end

  describe "edit guild_event" do
    setup [:create_guild_event]

    test "renders form for editing chosen guild_event", %{conn: conn, guild_event: guild_event} do
      conn = get(conn, Routes.guild_event_path(conn, :edit, guild_event))
      assert html_response(conn, 200) =~ "Edit Guild event"
    end
  end

  describe "update guild_event" do
    setup [:create_guild_event]

    test "redirects when data is valid", %{conn: conn, guild_event: guild_event} do
      conn =
        put(conn, Routes.guild_event_path(conn, :update, guild_event), guild_event: @update_attrs)

      assert redirected_to(conn) == Routes.guild_event_path(conn, :show, guild_event)

      conn = get(conn, Routes.guild_event_path(conn, :show, guild_event))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, guild_event: guild_event} do
      conn =
        put(conn, Routes.guild_event_path(conn, :update, guild_event), guild_event: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Guild event"
    end
  end

  describe "delete guild_event" do
    setup [:create_guild_event]

    test "deletes chosen guild_event", %{conn: conn, guild_event: guild_event} do
      conn = delete(conn, Routes.guild_event_path(conn, :delete, guild_event))
      assert redirected_to(conn) == Routes.guild_event_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.guild_event_path(conn, :show, guild_event))
      end
    end
  end

  defp create_guild_event(_) do
    guild_event = fixture(:guild_event)
    %{guild_event: guild_event}
  end
end
