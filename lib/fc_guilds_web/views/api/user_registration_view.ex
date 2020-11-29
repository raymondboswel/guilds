defmodule FcGuildsWeb.API.UserRegistrationView do
  use FcGuildsWeb, :view

  def render("token.json", %{token:  token}) do
    %{data: %{
         token: token
      }}
  end

  def render("error.json", %{changeset:  changeset}) do
    %{data: %{
         errors: "Could not register user"
      }}
  end
end
