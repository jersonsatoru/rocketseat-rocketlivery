defmodule Rocketlivery.Orders.Create do
  import Ecto.Query

  alias URI.Error
  alias Rocketlivery.{Repo, Item, Order, Error}
  alias Rocketlivery.Orders.ValidateItems

  @spec call(map) :: {:ok, Order.t()} | {:error, any}
  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  @spec fetch_items(map) :: any
  defp fetch_items(%{"items" => items}) do
    items_ids = Enum.map(items, fn item -> item["id"] end)
    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateItems.call(items_ids, items)
  end

  defp handle_items({:error, %Error{}} = result, _params), do: result

  defp handle_items({:ok, items}, params) do
    Order.changeset(params, items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}),
    do: {:error, Error.build(:bad_request, changeset)}
end
