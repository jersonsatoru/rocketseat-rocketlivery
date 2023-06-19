defmodule Rocketlivery do
  @moduledoc """
  Rocketlivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Rocketlivery.Users.Create, as: UserCreate
  alias Rocketlivery.Users.FindUserById, as: FindUserById
  alias Rocketlivery.Users.Delete, as: DeleteUser

  @spec create_user(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  defdelegate create_user(params), to: UserCreate, as: :call

  @spec find_user_by_id(String.t()) :: User.t()
  defdelegate find_user_by_id(id), to: FindUserById, as: :call

  @spec delete_user(binary) :: {:error, Rocketlivery.Error.t()} | {:ok, any}
  defdelegate delete_user(id), to: DeleteUser, as: :call
end
