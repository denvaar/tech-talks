defmodule TechTalksWeb.Router do
  use TechTalksWeb, :router

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

  scope "/", TechTalksWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", AboutController, :index

    resources "/topics", TopicController, only: [:index, :new, :create]
    resources "/talks", TalkController, only: [:index, :new, :create]
  end

  scope "/api", TechTalksWeb do
    pipe_through :api

    patch "/topics/:id/like", TopicController, :like_topic
  end
end
