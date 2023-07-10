defmodule RocketliveryWeb.UserController do
  use RocketliveryWeb, :controller

  alias RocketliveryWeb.FallbackController

  alias Rocketlivery.User

  alias RocketliveryWeb.Auth.Guardian

  action_fallback FallbackController

  @spec create(Plug.Conn.t(), any) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketlivery.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> json(%{
        message: "User created successfully",
        token: token,
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

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with %User{} = user <- Rocketlivery.find_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> json(%{
        message: "User found successfully",
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

  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- Rocketlivery.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, params) do
    with {:ok, %User{} = user} <- Rocketlivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> json(%{
        message: "User updated successfully",
        user: %User{
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

  def signin(conn, params) do
    with {:ok, token} <- Rocketlivery.user_signin(params) do
      conn
      |> put_status(:ok)
      |> json(%{
        message: "Sign in successful",
        token: token,
      })
    end
  end
end
