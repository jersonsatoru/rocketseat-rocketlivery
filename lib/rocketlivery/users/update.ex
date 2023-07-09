defmodule Rocketlivery.Users.Update do
  alias Rocketlivery.{User, Repo}

  def call(params) do
    case update_user(params) do
      {:ok, %User{} = user} -> {:ok, user}
      {:error, result} -> {:error, result}
    end
  end

  defp update_user(%{"id" => id} = params) do
    Repo.get(User, id)
    |> User.changeset(params)
    |> Repo.update()
  end
end
