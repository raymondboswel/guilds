defmodule FcGuildsWeb.API.UserSessionView do
  use FcGuildsWeb, :view

  def render("token.json", %{token:  token}) do
    %{data: %{
         token: token
      }}
  end

  def render("auth_fail.json", _ignore) do
    %{data: %{
         message: "Invalid username or password"
      }}
  end
end
