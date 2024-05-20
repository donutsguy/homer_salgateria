defmodule HomerSalgateriaWeb.Router do
  use HomerSalgateriaWeb, :router

  # procuramos um token para carregar o recurso.
  pipeline :auth do
    plug HomerSalgateria.Account.AuthPipe
  end

  # exigimos um certo token.
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HomerSalgateriaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HomerSalgateriaWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :home
    resources "/stocks", StockController

    # resources "/users", UserController
  end

  scope "/", HomerSalgateriaWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/protected", PageController, :protected
  end

  scope "/user", HomerSalgateriaWeb do
    pipe_through [:browser, :auth]

    resources "/register", RegisterController, only: [:new, :create]

    resources "/login", UserSessionController, only: [:new, :create]
    get "/logout", UserSessionController, :logout

    resources "/settings", UserSessionController, only: [:edit, :update]
    # delete "/settings/:id", UserSettingsController, :delete

    resources "/reset_password", ResetPasswordController, except: [:index, :show, :delete]
  end

  scope "/supplies", HomerSalgateriaWeb do
    pipe_through [:browser]

    resources "/", SupplyController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HomerSalgateriaWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:homer_salgateria, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HomerSalgateriaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
