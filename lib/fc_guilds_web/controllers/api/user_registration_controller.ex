defmodule FcGuildsWeb.API.UserRegistrationController do
  use FcGuildsWeb, :controller

  alias FcGuilds.Accounts
  alias FcGuilds.Accounts.User
  alias FcGuildsWeb.UserAuth

  def register(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        token = Accounts.generate_user_session_token(user)

        conn
        |> render("token.json", token: token)


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
end
