ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Rocketlivery.Repo, :manual)

Mox.defmock(ZipcodeGateway.ClientMock, for: ZipcodeGateway.Behavior)
