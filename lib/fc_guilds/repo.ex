defmodule FcGuilds.Repo do
  use Ecto.Repo,
    otp_app: :fc_guilds,
    adapter: Ecto.Adapters.Postgres
end
