defmodule Rocketlivery do
  @moduledoc """
  Rocketlivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Rocketlivery.Users.Create, as: UserCreate

  @spec create_user(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  defdelegate create_user(params), to: UserCreate, as: :call
end
