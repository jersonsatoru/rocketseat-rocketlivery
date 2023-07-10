defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory
  import Mox

  alias Rocketlivery.Users.Create
  alias Rocketlivery.{Error, User}

  describe "call/1" do
    test "when all params are valid, return the user" do
      expect(ZipcodeGateway.ClientMock, :get_address_information_by_zipcode, fn _cep -> {
        :ok, build(:zipcode_gateway)
      } end)

      params = build(:user_params)
      response = Create.call(params)

      assert {:ok, %User{}} = response
    end

    test "when some params are invalid should return error" do
      expect(ZipcodeGateway.ClientMock, :get_address_information_by_zipcode, fn _cep -> {
        :ok, build(:zipcode_gateway)
      } end)

      params = build(:user_params, %{"age" => 15})
      response = Create.call(params)

      assert {:error, %Error{status: :bad_request}} = response
    end

    test "when zipcode is invalid should return Invalid CEP error" do
      expect(ZipcodeGateway.ClientMock, :get_address_information_by_zipcode, fn _cep -> {
        :error, %Error{
          status: :bad_request,
          result: "Zipcode not found"
        }
      } end)

      params = build(:user_params, %{"cep" => "00000000"})
      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: "Zipcode not found"}} = response
    end
  end
end
