defmodule RocketliveryWeb.UserControllerTest do
  use RocketliveryWeb.ConnCase

  import Rocketlivery.Factory

  describe "create" do
    test "when all params are valid should create a new user", %{conn: conn} do
      response = conn
      |> post(~p"/api/users", build(:user_params))
      |> json_response(:created)

      assert %{"user" => %{"name" => _}} = response
    end

    test "when some params are invalid should return error", %{conn: conn} do
      response = conn
        |> post(~p"/api/users", build(:user_params, %{"age" => 15}))
        |> json_response(:bad_request)

      assert %{"message" => %{"age" => _}} = response
    end
  end

  describe "delete" do
    test "when there is a user with the given ID", %{conn: conn} do
      insert(:user)
      response =
        conn
        |> delete(~p"/api/users/56bf846a-1080-45cc-bb7f-e766ece59a33")
        |> response(:no_content)

      expected_response = ""
      assert response == expected_response
    end
  end
end
