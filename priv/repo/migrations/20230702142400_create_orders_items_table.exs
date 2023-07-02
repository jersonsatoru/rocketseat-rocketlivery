defmodule Rocketlivery.Repo.Migrations.CreateOrdersItemsTable do
  use Ecto.Migration

  def change do
    create table(:order_items, primary_key: false) do
      add :order_id, references(:orders, type: :binary_id)
      add :item_id, referentes(:items, type: :binary_id)
    end
  end
end
