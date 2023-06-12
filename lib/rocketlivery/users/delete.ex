defmodule Rocketlivery.Users.Delete do
  alias Ecto.Changeset
  alias Rocketlivery.{User, Repo}

  def call(id) do
    with {:ok, id} <- validate_uuid(id), {:ok, %User{} = user} <- get_user_by_id(id) do
      delete_user(user)
    end
  end

  def validate_uuid(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalud UUID format"}}
      {:ok, _} = result -> result
    end
  end

  defp get_user_by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, %{status: :not_found, result: "User not found"}}
    end
  end

  defp delete_user(user) do
    case Repo.delete(user) do
      {:ok, _} -> :ok
      {:error, %Changeset{} = changeset} -> {:error, status: :bad_request, result: changeset}
    end
  end
end
