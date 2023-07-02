defmodule Rocketlivery.UserTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all params are valid, return a valid changeset" do
      changeset = User.changeset(build(:user_params))
      assert %Changeset{valid?: true} = changeset
    end

    test "when all params are valid except age, return an invalid changeset" do
      params = build(:user_params, %{"age" => 15})
      changeset = User.changeset(params)
      assert %Changeset{valid?: false, errors: [age: {"is invalid", _}]} = changeset
    end

    test "when updating changeset, returns a updated changeset" do
      changeset = User.changeset(build(:user_params))
      updated_changeset = User.changeset(changeset, %{"name" => "Pablo"})

      assert %Changeset{valid?: true, changes: %{name: "Pablo"}} = updated_changeset
    end
  end
end
