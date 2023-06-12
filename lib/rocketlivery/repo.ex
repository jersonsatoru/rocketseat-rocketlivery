defmodule Rocketlivery.Repo do
  use Ecto.Repo,
    otp_app: :rocketlivery,
    adapter: Ecto.Adapters.Postgres
end
