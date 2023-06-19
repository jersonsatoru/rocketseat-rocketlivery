defmodule Rocketlivery.Users.Delete do
  alias Ecto.Changeset
  alias Rocketlivery.{User, Repo, Error}

  @spec call(String.t()) :: {:ok, any()} | {:error, Rocketlivery.Error.t()}
  def call(id) do
    with {:ok, id} <- validate_uuid(id),
         {:ok, %User{} = user} <- get_user_by_id(id),
         {:ok, result} <- delete_user(user) do
      {:ok, result}
    else
      {:error, %Error{} = error} -> {:error, error}
    end
  end

  def validate_uuid(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, Error.build_invalid_uuid_format_error}
      {:ok, _} = result -> result
    end
  end

  defp get_user_by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found_error}
    end
  end

  defp delete_user(user) do
    case Repo.delete(user) do
      {:ok, _} = result -> result
      {:error, %Changeset{} = changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
