defmodule DebugPhoenixJs.FeatureCase do
  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox

  @password "p0bl4n0123"

  using do
    quote do
      use DebugPhoenixJsWeb, :verified_routes

      import DebugPhoenixJs.FeatureCase
      import Wallaby.Browser
      import Wallaby.Feature

      alias Wallaby.Query

      @endpoint PoblanoWeb.Endpoint
    end
  end

  setup tags do
    pid = Sandbox.start_owner!(DebugPhoenixJs.Repo, shared: not tags[:async])
    on_exit(fn -> Sandbox.stop_owner(pid) end)
    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for([DebugPhoenixJs.Repo], self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
