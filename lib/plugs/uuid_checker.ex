defmodule RocketliveryWeb.Plugs.UUIDChecker do
  import Plug.Conn

  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case Ecto.UUID.cast(id) do
      {:ok, _} -> conn
      :error -> render_error(conn)
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{"message" => "Invalid UUID format"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
