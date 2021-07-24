defmodule FcGuildsWeb.API.OrganizationView do
  use FcGuildsWeb, :view

  def render("show.json", %{organization: organization}) do
    %{data: render_one(organization, FcGuildsWeb.API.OrganizationView, "organization.json")}
  end

  def render("organizations.json", %{organizations: organizations}) do
    %{data: render_many(organizations, FcGuildsWeb.API.OrganizationView, "organization.json")}
  end

  def render("organization.json", %{organization: organization}) do
    if not Ecto.assoc_loaded?(organization.guilds) do
    %{ name: organization.name,
       id: organization.id
      }
    else

      %{
        name: organization.name,
        id: organization.id,
        guilds: FcGuildsWeb.API.GuildView.render("guilds.json", %{guilds: organization.guilds})
      }
    end
  end


end
