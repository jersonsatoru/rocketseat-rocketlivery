defmodule RocketliveryWeb.OrderController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Order
  alias RocketliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Order{} = order} <- Rocketlivery.create_order(params) do
      conn
      |> put_status(:created)
      |> json(%{
        message: "Order created successfully",
        order: %{
          id: order.id,
          comment: order.comment,
          address: order.address,
          items: order.items,
          payment_method: order.payment_method,
          user_id: order.user_id
        }
      })
    end
  end
end
