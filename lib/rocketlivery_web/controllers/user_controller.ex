defmodule RocketliveryWeb.UserController do
  use RocketliveryWeb, :controller

  alias RocketliveryWeb.FallbackController
  alias Rocketlivery.User

  action_fallback FallbackController

  @spec create(Plug.Conn.t(), any) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, %User{} = user} <-  Rocketlivery.create_user(params) do
      conn
        |> put_status(:created)
        |> json(%{
            message: "User created successfully",
            user: %{
              id: user.id,
              name: user.name,
              email: user.email,
              address: user.address,
              cpf: user.cpf,
              cep: user.cep,
              age: user.age
            }
          })
    end
  end
end
