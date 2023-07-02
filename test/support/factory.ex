defmodule Rocketlivery.Factory do
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
end
