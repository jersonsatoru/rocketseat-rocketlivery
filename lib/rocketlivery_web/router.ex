defmodule RocketliveryWeb.Router do
  use RocketliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RocketliveryWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
  end
end
