defmodule FcGuildsWeb.API.OrganizationController do
  use FcGuildsWeb, :controller

  alias FcGuilds.Organizations
  alias FcGuilds.Organizations.Organization
  alias FcGuilds.Repo

  def index(conn, _params) do
    user = conn.assigns.current_user
    organizations = Organizations.list_organizations(user)
    render(conn, "organizations.json", organizations: organizations)
  end

  def link(conn, _params) do
  end

  def show(conn, %{"id" => id}) do
    organization = Organizations.get_organization!(id) |> Repo.preload(:guilds)
    render(conn, "show.json", organization: organization)
  end

  # def new(conn, _params) do
  #   changeset = Organizations.change_organization(%Organization{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"organization" => organization_params}) do
  #   user = conn.assigns.current_user

  #   case Organizations.create_organization(organization_params, user) do
  #     {:ok, organization} ->
  #       conn
  #       |> put_flash(:info, "Organization created successfully.")
  #       |> redirect(to: Routes.organization_path(conn, :show, organization))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       IO.inspect(changeset)
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end



  # def guilds(conn, %{"organization_id" => org_id}) do
  #   user = conn.assigns.current_user |> Repo.preload(:guilds)
  #   organization = FcGuilds.Organizations.get_organization!(org_id) |> Repo.preload(:guilds)
  #   render(conn, "guilds.html", user: user, organization: organization)
  # end

  # def users(conn, %{"organization_id" => org_id}) do
  #   organization = FcGuilds.Organizations.get_organization!(org_id) |> Repo.preload(:users)
  #   render(conn, "users.html", organization: organization)
  # end

  # def edit(conn, %{"id" => id}) do
  #   organization = Organizations.get_organization!(id)
  #   changeset = Organizations.change_organization(organization)
  #   render(conn, "edit.html", organization: organization, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "organization" => organization_params}) do
  #   organization = Organizations.get_organization!(id)

  #   case Organizations.update_organization(organization, organization_params) do
  #     {:ok, organization} ->
  #       conn
  #       |> put_flash(:info, "Organization updated successfully.")
  #       |> redirect(to: Routes.organization_path(conn, :show, organization))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", organization: organization, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   organization = Organizations.get_organization!(id)
  #   {:ok, _organization} = Organizations.delete_organization(organization)

  #   conn
  #   |> put_flash(:info, "Organization deleted successfully.")
  #   |> redirect(to: Routes.organization_path(conn, :index))
  # end
end
