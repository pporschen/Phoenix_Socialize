defmodule SocializeWeb.ProfileController do
  use SocializeWeb, :controller

  alias Socialize.Profiles
  alias Socialize.Profiles.Profile

  def index(conn, _params) do
    profiles = Profiles.list_profiles()
    render(conn, "index.html", profiles: profiles)
  end

  def new(conn, _params) do
    
    changeset = Profiles.change_profile(%Profile{})
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"profile" => profile_params} = params) do
    IO.inspect(params)
    changeset = conn.assigns.current_user
    case Profiles.create_profile(changeset, profile_params) do
      {:ok, profile} ->
        conn
        |> put_flash(:info, "Profile created successfully.")
        |> redirect(to: Routes.profile_path(conn, :show, profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    profile = Profiles.get_profile!(id)
    render(conn, "show.html", profile: profile)
  end

  def edit(conn, %{"id" => id}) do
    profile = Profiles.get_profile!(id)
    changeset = Profiles.change_profile(profile)
    render(conn, "edit.html", profile: profile, changeset: changeset)
  end

  def update(conn, %{"id" => id, "profile" => profile_params}) do
    profile = Profiles.get_profile!(id)

    case Profiles.update_profile(profile, profile_params) do
      {:ok, profile} ->
        conn
        |> put_flash(:info, "Profile updated successfully.")
        |> redirect(to: Routes.profile_path(conn, :show, profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", profile: profile, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Profiles.get_profile!(id)
    {:ok, _profile} = Profiles.delete_profile(profile)

    conn
    |> put_flash(:info, "Profile deleted successfully.")
    |> redirect(to: Routes.profile_path(conn, :index))
  end
end
