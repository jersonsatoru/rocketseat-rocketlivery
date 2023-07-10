defmodule Rocketlivery.Users.Create do
  alias Ecto.Changeset
  alias Rocketlivery.{User, Repo, Error}

  @spec call(map()) :: {:ok, User.t()} | {:error, Error.t()}
  def call(params) do
    with %Changeset{} = changeset <- User.changeset(params),
         {:ok, %User{} = user} <- Changeset.apply_action(changeset, :create),
         {:ok, %User{} = user} <- complete_address(user),
         {:ok, _} = result <- Repo.insert(user) do
      result
    else
      {:error, %Error{}} = result -> result
      {:error, error} -> {:error, Error.build(:bad_request, error)}
    end
  end


  defp complete_address(%User{cep: zipcode} = user) do
    case client().get_address_information_by_zipcode(zipcode) do
      {:ok, %ZipcodeGateway.Client{} = client} ->
        {
          :ok,
          %User{user | address: ZipcodeGateway.Client.build_full_address(client)}
        }
      {:error, _error} = result -> result
    end
  end

  @spec client :: ZipcodeGateway.Behavior
  defp client do
    :rocketlivery
    |> Application.fetch_env!(Rocketlivery.Users.Create)
    |> Keyword.get(:zipcode_gateway_adapter)
  end
end
