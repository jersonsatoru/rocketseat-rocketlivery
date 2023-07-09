defmodule Rocketlivery.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  @type status :: atom()
  @type result :: any()
  @type t :: %__MODULE__{
          status: status,
          result: result
        }
  defstruct @keys

  @spec build(atom(), any()) :: Rocketlivery.Error.t()
  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  @spec build_invalid_uuid_format_error :: Rocketlivery.Error.t()
  def build_invalid_uuid_format_error, do: build(:bad_request, "Invalid UUID format")

  @spec build_user_not_found_error :: Rocketlivery.Error.t()
  def build_user_not_found_error, do: build(:not_found, "User not found")
end
