defmodule FcGuildsWeb.API.UserSessionController do
  use FcGuildsWeb, :controller

  alias FcGuilds.Accounts
  alias FcGuildsWeb.UserAuth

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params
    user = Accounts.get_user_by_email_and_password(email, password)
    IO.inspect user
    if user do

      token = Accounts.generate_user_session_token(user)
      render(conn, "token.json", token: token)
    else
      IO.inspect "Rendering error"
      conn
      |> put_status(401)
      |> render("auth_fail.json", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
