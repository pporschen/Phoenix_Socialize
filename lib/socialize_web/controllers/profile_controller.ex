defmodule SocializeWeb.ProfileController do
  use SocializeWeb, :controller

  alias Socialize.Profiles
  alias Socialize.Profiles.Profile
  alias Socialize.Repo

  plug :is_allowed_to_visit when action in [:edit, :delete, :update]

  def index(conn, _params) do
    profiles = Profiles.list_profiles()
    IO.inspect(profiles)
    render(conn, "index.html", profiles: profiles)
  end

  def new(conn, _params) do
    
    changeset = Profiles.change_profile(%Profile{})
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"profile" => profile_params} = params) do
     
    
    if upload = profile_params["photo"] do
      IO.puts "jjjjjj"
      extension = Path.extname(upload.filename)
      File.cp(upload.path, "./priv/static/files/#{profile_params["id"]}-profile#{extension}")
    end
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

  defp is_allowed_to_visit(%Plug.Conn{params: %{"id" => id}} = conn, params) do
    res = Repo.get(Profile, id).user_id
  
    if res == conn.assigns.current_user.id do
      conn
    else
      conn
      |> put_flash(:info, "Nope.")
      |> redirect(to: Routes.profile_path(conn, :index))
      |> halt()
    end
  end
end
