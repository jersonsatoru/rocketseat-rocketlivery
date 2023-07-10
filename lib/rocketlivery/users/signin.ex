defmodule Rocketlivery.Users.Signin do
  alias Rocketlivery.Error
  alias RocketliveryWeb.Auth.Guardian
  alias Rocketlivery.{Repo, User}

  import Ecto.Query

  def call(%{"email" => email, "password" => password}) do
    query = from user in User, where: user.email == ^email

    with %User{} = user <- Repo.one(query),
         {:ok, _token} = result <- Guardian.auth(user, password) do
      result
    else
      {:error, %Error{}} = result -> result
      {:error, result} -> {:error, Error.build(:unauthorized, result)}
    end
  end
end
