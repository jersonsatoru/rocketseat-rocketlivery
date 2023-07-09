defmodule Rocketlivery.Users.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{User, Repo, Error}

  @spec call(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          Error.t() | {:ok, any}
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_user_insert()
  end

  defp handle_user_insert({:ok, _} = result), do: result

  defp handle_user_insert({:error, %Changeset{} = changeset}) do
    {:error, %Error{status: :bad_request, result: changeset}}
  end
end
