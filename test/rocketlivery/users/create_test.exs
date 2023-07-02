defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Users.Create
  alias Rocketlivery.{Error, User}

  describe "call/1" do
    test "when all params are valid, return the user" do
      params = build(:user_params)
      response = Create.call(params)

      assert {:ok, %User{}} = response
    end

    test "when some params are invalid should return error" do
      params = build(:user_params, %{"age" => 15})
      response = Create.call(params)

      assert {:error, %Error{status: :bad_request}} = response
    end
  end
end
