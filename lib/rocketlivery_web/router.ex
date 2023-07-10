defmodule RocketliveryWeb.Router do
  alias RocketliveryWeb.Plugs.UUIDChecker

  use RocketliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  scope "/api", RocketliveryWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]

    post "/users/signin", UserController, :signin

    resources "/items", ItemController, except: [:new, :edit]

    resources "/orders", OrderController, except: [:new, :edit]
  end
end
