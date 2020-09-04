defmodule Socialize.Repo do
  use Ecto.Repo,
    otp_app: :socialize,
    adapter: Ecto.Adapters.Postgres
end
