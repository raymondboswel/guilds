defmodule FcGuildsWeb.API.GuildView do
  use FcGuildsWeb, :view

  def render("show.json", %{guild: guild}) do
    %{data: render_one(guild, FcGuildsWeb.API.GuildView, "guild.json")}
  end

  def render("guilds.json", %{guilds: guilds}) do
    %{data: render_many(guilds, FcGuildsWeb.API.GuildView, "guild.json")}
  end

  def render("guild.json", %{guild: guild}) do
    if Ecto.assoc_loaded?(guild.users) do
    %{ name: guild.name,
       id: guild.id
      }
    else
      %{
        name: guild.name,
        id: guild.id,
      }
    end
  end

  def render("create_fail.json", %{error: error_message}) do
    %{
      error: error_message
    }
  end

end
