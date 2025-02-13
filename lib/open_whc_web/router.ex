defmodule OpenWhcWeb.Router do
  use OpenWhcWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OpenWhcWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OpenWhcWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api/v1", OpenWhcWeb do
    pipe_through :api

    get "/whc_sites", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", OpenWhcWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:open_whc, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
