import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :debug_phoenix_js, DebugPhoenixJs.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "debug_phoenix_js_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :debug_phoenix_js, DebugPhoenixJsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "grURbfaCII/Jd+KQ411hKzGOMhyVeps6geugRWdQLKaYQ1skH4Ja9AmwQP5Azek9",
  server: true

# In test we don't send emails.
config :debug_phoenix_js, DebugPhoenixJs.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Wallaby
config :wallaby,
  driver: Wallaby.Chrome,
  otp_app: :debug_phoenix_js,
  screenshot_on_failure: true,
  chromedriver: [
    capabilities: %{
      javascriptEnabled: true,
      loadImages: false,
      rotatable: false,
      takesScreenshot: true,
      cssSelectorsEnabled: true,
      nativeEvents: false,
      platform: "ANY",
      unhandledPromptBehavior: "accept",
      chromeOptions: %{
        args: [
          "--no-sandbox",
          "window-size=1280,800",
          "--disable-gpu",
          "--headless",
          "--fullscreen",
          "--user-agent=Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
        ]
      }
    }
  ]
