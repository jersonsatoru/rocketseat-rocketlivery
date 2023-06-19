defmodule Rocketlivery.Users.FindUserById do
  alias Rocketlivery.{Repo, User, Error}
  alias Ecto.UUID

  @spec call(String.t()) :: User.t()
  def call(id) do
    id
      |> UUID.cast()
      |> get_user_by_id
  end

  defp get_user_by_id(:error) do
    {:error, Error.build_invalid_uuid_format_error()}
  end

  defp get_user_by_id({:ok, id}) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      %User{} = user -> user
      _ -> {:error, Error.build(:bad_request, "Something went wrong")}
    end
  end
end
