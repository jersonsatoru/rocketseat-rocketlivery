defmodule Rocketlivery do
  @moduledoc """
  Rocketlivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Rocketlivery.Order
  alias URI.Error
  alias Rocketlivery.Users.Create, as: UserCreate
  alias Rocketlivery.Users.FindUserById, as: FindUserById
  alias Rocketlivery.Users.Delete, as: DeleteUser
  alias Rocketlivery.Users.Update, as: UpdateUser
  alias Rocketlivery.Items.Create, as: ItemCreate
  alias Rocketlivery.Orders.Create, as: CreateOrder
  alias Rocketlivery.Users.Signin, as: UserSignin

  @spec create_user(map) :: {:ok, Item.t()} | {:error, any}
  defdelegate create_user(params), to: UserCreate, as: :call

  @spec find_user_by_id(String.t()) :: User.t()
  defdelegate find_user_by_id(id), to: FindUserById, as: :call

  @spec delete_user(binary) :: {:error, Rocketlivery.Error.t()} | {:ok, any}
  defdelegate delete_user(id), to: DeleteUser, as: :call

  @spec update_user(map) :: {:ok, User.t()} | {:error, any}
  defdelegate update_user(params), to: UpdateUser, as: :call

  @spec create_item(map) :: {:ok, Item.t()} | {:error, Error.t()}
  defdelegate create_item(params), to: ItemCreate, as: :call

  @spec create_order(map) :: {:ok, Order.t()} | {:error, Error.t()}
  defdelegate create_order(params), to: CreateOrder, as: :call

  @spec user_signin(map) :: {:ok, String.t()} | {:error, Error.t()}
  defdelegate user_signin(params), to: UserSignin, as: :call
end
