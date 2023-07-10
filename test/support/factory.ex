defmodule Rocketlivery.Factory do
  alias Rocketlivery.Item
  alias Rocketlivery.User

  use ExMachina.Ecto, repo: Rocketlivery.Repo

  def user_params_factory do
    %{
      "name" => "Jerson",
      "age" => 18,
      "address" => "Rua Senador Dantas, 15",
      "cep" => "08880100",
      "cpf" => "37013403822",
      "email" => "jersonsatoru@yahoo.com.br",
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      id: "56bf846a-1080-45cc-bb7f-e766ece59a33",
      name: "Jerson",
      age: 18,
      address: "Rua Senador Dantas, 15",
      cep: "08880100",
      cpf: "37013403822",
      email: "jersonsatoru@yahoo.com.br",
      password: "123456"
    }
  end

  def item_factory do
    %Item{
      category: :food,
      description: "Feijoada",
      photo: "banana.png",
      price: 20.00,
      id: "56bf846a-1080-45cc-bb7f-e766ece59a32"
    }
  end

  def zipcode_gateway_factory do
    %ZipcodeGateway.Client{
      state: "SP",
      city: "Mogi das Cruzes",
      address: "Rua Senador Dantas, 15",
      district: "Centro"
    }
  end
end
