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

    resources "/items", ItemController, except: [:new, :edit]

    resources "/orders", OrderController, except: [:new, :edit]
  end
end
