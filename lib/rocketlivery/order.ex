defmodule Rocketlivery.Order do
  alias Rocketlivery.{User, Item}
  alias Ecto.{Enum, Changeset}

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @foreign_key_type :binary_id

  @required_params [:comment, :address, :payment_method, :user_id]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  @payment_methods [:money, :debit_card, :credit_card]

  schema "orders" do
    field :comment, :string
    field :payment_method, Enum, values: @payment_methods
    field :address, :string

    many_to_many :items, Item, join_through: "order_items"
    belongs_to :user, User

    timestamps()
  end

  @spec changeset(Order.t() | Changeset, list(Item.t())) :: Changeset | Order.t()
  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:items, items)
    |> validate_length(:address, min: 6)
  end
end
