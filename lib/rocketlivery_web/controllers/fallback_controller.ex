defmodule RocketliveryWeb.FallbackController do
  alias Ecto.Changeset

  import Ecto.Changeset, only: [traverse_errors: 2]

  use RocketliveryWeb, :controller

  def call(conn, {:error, %{status: status, result: %Changeset{} = result}}) do
    conn
      |> put_status(status)
      |> json(%{
        message: translate_errors(result)
      })
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
