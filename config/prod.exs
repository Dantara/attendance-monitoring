use Mix.Config

config :attendance_app, AttendanceAppWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "attendance-inno.herokuapp.com", port: 443],
  live_view: [
    signing_salt: System.get_env("SECRET_KEY_BASE")
  ],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  check_origin: ["https://attendance-inno.herokuapp.com"]

config :logger, level: :info

config :attendance_app, AttendanceAppWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# import_config "prod.secret.exs"
