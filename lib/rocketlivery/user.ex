defmodule Rocketlivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:age, :name, :email, :address, :cep, :cpf, :password]

  @visible_fields [:id, :age, :name, :email, :address, :cep, :cpf]

  @derive {Jason.Encoder, only: @visible_fields}

  schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    timestamps()
  end

  @spec changeset(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          Ecto.Changeset.t()
  def changeset(params) do
    %__MODULE__{}
      |> cast(params, @required_params)
      |> validate_required(@required_params)
      |> validate_inclusion(:age, 18..120)
      |> validate_length(:cep, is: 8)
      |> validate_length(:cpf, is: 11)
      |> validate_format(:email, ~r/\w+@/)
      |> unique_constraint([:email])
      |> unique_constraint([:cpf])
      |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
