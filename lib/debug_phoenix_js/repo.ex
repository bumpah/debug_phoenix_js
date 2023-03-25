defmodule DebugPhoenixJs.Repo do
  use Ecto.Repo,
    otp_app: :debug_phoenix_js,
    adapter: Ecto.Adapters.Postgres
end
