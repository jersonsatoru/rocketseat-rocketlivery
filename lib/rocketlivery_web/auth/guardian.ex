defmodule RocketliveryWeb.Auth.Guardian do
  alias Rocketlivery.Error
  alias Rocketlivery.User

  use Guardian, otp_app: :rocketlivery

  def subject_for_token(%User{id: id}, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    {:ok, id}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In above `subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    user = Rocketlivery.find_user_by_id(id)
    {:ok,  user}
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  @spec auth(User.t(), String.t()) :: {:ok, String.t()} | {:error, Error.t()}
  def auth(%User{password_hash: password_hash} = user, password) do
     case Pbkdf2.verify_pass(password, password_hash) do
        true ->
          {:ok, token, _claims} = encode_and_sign(user)
          {:ok, token}
        false -> {:error, Error.build(:unauthorized, "Invalid authentication")}
     end
  end
end
