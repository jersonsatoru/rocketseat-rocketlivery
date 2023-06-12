defmodule RocketliveryWeb.WelcomeController do
    use RocketliveryWeb, :controller

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, _) do
      conn
        |> put_status(:ok)
        |> json(
          %{
            message: "valor"
          }
        )
    end
end
