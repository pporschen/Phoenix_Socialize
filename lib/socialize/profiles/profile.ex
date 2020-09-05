defmodule Socialize.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :age, :integer
    field :first_name, :string
    field :name, :string
    belongs_to :user, Socialize.Users.User

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :name, :age])
    |> validate_required([:first_name, :name, :age])
  end
end
