defmodule Rocketlivery.Users.FindUserById do
  alias Rocketlivery.{Repo, User}
  alias Ecto.UUID

  @spec call(String.t()) :: User.t()
  def call(id) do
    id
      |> UUID.cast()
      |> get_user_by_id
  end

  defp get_user_by_id(:error) do
    {:error, %{status: :bad_request, result: "Invalid UUID format"}}
  end

  defp get_user_by_id({:ok, id}) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "User not found"}}
      %User{} = user -> user
      _ -> {:error, %{status: :bad_request, result: "Something went wrong"}}
    end
  end
end
