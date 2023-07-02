defmodule RocketliveryWeb.ItemController do
  use RocketliveryWeb, :controller

  alias RocketliveryWeb.FallbackController

  alias Rocketlivery.Item

  action_fallback FallbackController

  def create(conn, opts) do
    with {:ok, %Item{} = item} <- Rocketlivery.create_item(opts) do
      conn
      |> put_status(:created)
      |> json(%{
        message: "Item created successfuly",
        item: item
      })
    end
  end
end
