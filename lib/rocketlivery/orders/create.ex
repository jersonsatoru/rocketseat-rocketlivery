defmodule Rocketlivery.Orders.Create do
  import Ecto.Query

  alias URI.Error
  alias Rocketlivery.{Repo, Item, Order, Error}

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
      |> validate_items(items_ids, items)
  end

  @spec validate_items(list(Item.t()), list(String.t()), map()) :: any
  defp validate_items(items, items_ids, items_param) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn item_id -> {item_id, Map.get(items_map, item_id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, items_param)
  end

  defp multiply_items(true, _items_map, _items_params),
    do: {
      :error,
      %Error{result: "There is an invalid item ID", status: :bad_request}
    }

  defp multiply_items(false, items_map, items_params) do
    items =
      Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(items_map, id)
        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end

  defp handle_items({:error, %Error{}} = result, _params), do: result

  defp handle_items({:ok, items}, params) do
    Order.changeset(params, items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}), do: {:error, Error.build(:bad_request, changeset)}
end
