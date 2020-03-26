# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :attendance_app,
  ecto_repos: [AttendanceApp.Repo]

# Configures the endpoint
config :attendance_app, AttendanceAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D/9wr5U0c7pRp9v6btiPjMsfnRdlYpajDkGdaCh0bmr7dhKk8LI3E2Zz7NQVc+sq",
  render_errors: [view: AttendanceAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AttendanceApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :attendance_app, :pow,
  user: AttendanceApp.Accounts.User,
  repo: AttendanceApp.Repo,
  web_module: AttendanceAppWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
