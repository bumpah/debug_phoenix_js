Application.put_env(:wallaby, :base_url, DebugPhoenixJsWeb.Endpoint.url())
{:ok, _} = Application.ensure_all_started(:wallaby)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(DebugPhoenixJs.Repo, :manual)
