defmodule ZipcodeGateway.Client do
  alias ZipcodeGateway.Behavior
  alias Rocketlivery.Error

  use Tesla

  @behaviour Behavior

  @keys [:address, :city, :state, :zipcode, :district]

  @type address :: String.t()
  @type address_number :: String.t()
  @type city :: String.t()
  @type state :: String.t()
  @type district :: String.t()
  @type zipcode :: String.t()
  @type t :: %__MODULE__{
    address: address,
    city: city,
    state: state,
    zipcode: zipcode,
    district: district,
  }
  defstruct @keys

  plug Tesla.Middleware.JSON

  plug Tesla.Middleware.BaseUrl, Application.fetch_env!(:rocketlivery, :zipcode_gateway)

  @spec get_address_information_by_zipcode(String.t()) :: {:ok, Tesla.Env.t()} | {:error, Error.t()}
  @impl ZipcodeGateway.Behavior
  def get_address_information_by_zipcode(zipcode) do
    "#{zipcode}/json"
    |> get()
    |> handle_gateway_response()
  end

  defp handle_gateway_response({
    :ok,
    %Tesla.Env{
      status: 200,
      body: %{"erro" => true}
    }
  }), do: {
    :error, Error.build(:bad_request, "Zipcode not found")
  }

  defp handle_gateway_response({
    :ok, %Tesla.Env{
      status: status
    }
  }) when status > 399 and status < 500, do: {
    :error,
    Error.build(:bad_request, "Request returned bad request #{status}")
  }

  defp handle_gateway_response({
    :ok, %Tesla.Env{
      status: status
    }
  }) when status > 500, do: {
    :error,
    Error.build(:internal_server, "Request returned internal server error StatusCode(#{status})")
  }


  defp handle_gateway_response({
    :ok,
    %Tesla.Env{
      status: status,
      body: %{
        "bairro" => district,
        "cep" => zipcode,
        "uf" => state,
        "localidade" => city,
        "logradouro" => address,
      }
    }
  }) when status == 200, do: {:ok, %__MODULE__{
    district: district,
    zipcode: zipcode,
    state: state,
    city: city,
    address: address,
  }}

  @spec build_full_address(ZipcodeGateway.Client.t()) :: String.t()
  def build_full_address(client) do
    "#{client.address}, #{client.district}, #{client.city}, #{client.state}"
  end
end
