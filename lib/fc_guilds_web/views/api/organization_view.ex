defmodule FcGuildsWeb.API.OrganizationView do
  use FcGuildsWeb, :view

  def render("organizations.json", %{organizations: organizations}) do
    %{data: render_many(organizations, FcGuildsWeb.API.OrganizationView, "organization.json")}
    end

  def render("organization.json", %{organization: organization}) do
    %{ name: organization.name,
       id: organization.id
      }
  end


end
