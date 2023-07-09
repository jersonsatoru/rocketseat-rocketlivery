defmodule Rocketlivery.Orders.ValidateItems do
  alias Rocketlivery.Error
  @spec call(list(Item.t()), list(String.t()), map()) :: any
  def call(items, items_ids, items_param) do
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
end
