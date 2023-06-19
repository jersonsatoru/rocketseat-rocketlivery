defmodule Rocketlivery.Users.Update do

  alias Rocketlivery.{User, Repo, Error}

  def call(params) do
    with {:ok, _} <- validate_uuid(params),
         {:ok, %User{} = user} <- update_user(params) do
      {:ok, user}
    else
      {:error, result} -> {:error, result}
    end
  end

  defp validate_uuid(%{"id" => id}) do
    case Ecto.UUID.cast(id) do
      {:ok, _} = result -> result
      :error -> {:error, Error.build_invalid_uuid_format_error}
    end
  end

  defp update_user(%{"id" => id} = params) do
    Repo.get(User, id)
      |> User.changeset(params)
      |> Repo.update()
  end
end
