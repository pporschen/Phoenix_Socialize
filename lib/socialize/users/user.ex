defmodule Socialize.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    has_many :profiles, Socialize.Profiles.Profile
    timestamps()
  end
end
