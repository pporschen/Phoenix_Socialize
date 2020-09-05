defmodule Socialize.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :string
      add :name, :string
      add :age, :integer

      timestamps()
    end

  end
end
