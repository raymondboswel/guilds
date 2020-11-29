defmodule FcGuildsWeb.API.UserSessionController do
  use FcGuildsWeb, :controller

  alias FcGuilds.Accounts
  alias FcGuildsWeb.UserAuth

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      token = Accounts.generate_user_session_token(user)
      render(conn, "token.json", token: token)
    else
      conn
      |> put_status(:unauthorized)
      render(conn, "auth_fail.json", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
