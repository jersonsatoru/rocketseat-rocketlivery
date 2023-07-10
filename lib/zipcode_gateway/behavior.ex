defmodule ZipcodeGateway.Behavior do
  alias Rocketlivery.Error

  @callback get_address_information_by_zipcode(String.t()) ::  {:ok, Tesla.Env.t()} | {:error, Error.t()}
end
