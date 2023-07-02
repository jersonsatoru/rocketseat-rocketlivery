defmodule Rocketlivery.Items.Create do
  alias Rocketlivery.Error
  alias Rocketlivery.Item

  @spec call(map) :: {:ok, Item.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> Item.changeset()
    |> Rocketlivery.Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, _} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
