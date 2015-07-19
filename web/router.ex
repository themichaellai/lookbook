defmodule Lookbook.Router do
  use Lookbook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Lookbook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Lookbook do
    pipe_through :api

    resources "/lookbooks", LookBookController
    resources "/looks", LookController
  end
end
