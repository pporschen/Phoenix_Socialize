defmodule SocializeWeb.Router do
  use SocializeWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", SocializeWeb do
    pipe_through [:browser, :protected]
    get "/new", ProfileController, :new
    get "/", ProfileController, :index
    get "/index", ProfileController, :index
    get "/profile/:id", ProfileController, :show
    post "/profile", ProfileController, :create
    get "/profile/:id/edit", ProfileController, :edit
    put "/profile/:id/update", ProfileController, :update
    delete "/profile/:id", ProfileController, :delete
    
    # Add your protected routes here
  end

  scope "/", SocializeWeb do
    pipe_through :browser

    
  end

  # Other scopes may use custom stacks.
  # scope "/api", SocializeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SocializeWeb.Telemetry
    end
  end
end
