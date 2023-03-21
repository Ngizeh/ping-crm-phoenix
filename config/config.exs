# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :vue_phoenix,
  ecto_repos: [VuePhoenix.Repo]

# Configures the endpoint
config :vue_phoenix, VuePhoenixWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: VuePhoenixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: VuePhoenix.PubSub,
  live_view: [signing_salt: "7JUYh2Q9"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :vue_phoenix, VuePhoenix.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :tailwind, version: "3.0.24", default: [
  args: ~w(
    --config=tailwind.config.js
    --input=css/app.css
    --output=../priv/static/assets/app.css
  ),
  cd: Path.expand("../assets", __DIR__)
]

config :inertia_phoenix,
  assets_version: 1,          # default 1
  inertia_layout: "app.html"

 config :upload, Upload.Adapters.Local,
    storage_path: "priv/static/uploads",
    public_path: "/uploads"

# config :upload, Upload.Adapters.Local,
#   storage_path: "priv/static/uploads",
#   public_path: "/uploads"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
