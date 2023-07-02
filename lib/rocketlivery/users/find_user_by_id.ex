defmodule Rocketlivery.Users.FindUserById do
  alias Rocketlivery.{Repo, User, Error}

  @spec call(String.t()) :: User.t()
  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> user
      _ -> {:error, Error.build(:bad_request, "Something went wrong")}
    end
  end
end
