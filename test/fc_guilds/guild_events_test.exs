defmodule FcGuilds.GuildEventsTest do
  use FcGuilds.DataCase

  alias FcGuilds.GuildEvents

  describe "guild_events" do
    alias FcGuilds.GuildEvents.GuildEvent

    @valid_attrs %{duration: 42, event_date: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{duration: 43, event_date: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{duration: nil, event_date: nil, title: nil}

    def guild_event_fixture(attrs \\ %{}) do
      {:ok, guild_event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GuildEvents.create_guild_event()

      guild_event
    end

    test "list_guild_events/0 returns all guild_events" do
      guild_event = guild_event_fixture()
      assert GuildEvents.list_guild_events() == [guild_event]
    end

    test "get_guild_event!/1 returns the guild_event with given id" do
      guild_event = guild_event_fixture()
      assert GuildEvents.get_guild_event!(guild_event.id) == guild_event
    end

    test "create_guild_event/1 with valid data creates a guild_event" do
      assert {:ok, %GuildEvent{} = guild_event} = GuildEvents.create_guild_event(@valid_attrs)
      assert guild_event.duration == 42
      assert guild_event.event_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert guild_event.title == "some title"
    end

    test "create_guild_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GuildEvents.create_guild_event(@invalid_attrs)
    end

    test "update_guild_event/2 with valid data updates the guild_event" do
      guild_event = guild_event_fixture()

      assert {:ok, %GuildEvent{} = guild_event} =
               GuildEvents.update_guild_event(guild_event, @update_attrs)

      assert guild_event.duration == 43
      assert guild_event.event_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert guild_event.title == "some updated title"
    end

    test "update_guild_event/2 with invalid data returns error changeset" do
      guild_event = guild_event_fixture()

      assert {:error, %Ecto.Changeset{}} =
               GuildEvents.update_guild_event(guild_event, @invalid_attrs)

      assert guild_event == GuildEvents.get_guild_event!(guild_event.id)
    end

    test "delete_guild_event/1 deletes the guild_event" do
      guild_event = guild_event_fixture()
      assert {:ok, %GuildEvent{}} = GuildEvents.delete_guild_event(guild_event)
      assert_raise Ecto.NoResultsError, fn -> GuildEvents.get_guild_event!(guild_event.id) end
    end

    test "change_guild_event/1 returns a guild_event changeset" do
      guild_event = guild_event_fixture()
      assert %Ecto.Changeset{} = GuildEvents.change_guild_event(guild_event)
    end
  end
end
