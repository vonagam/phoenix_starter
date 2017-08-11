use Mix.Config


config( :phoenix, :template_engines,

  slime: PhoenixSlime.Engine,

)

config( :logger, :console,

  format: "$time $metadata[$level] $message\n",

  metadata: [ :request_id ],

)

config( :phx,

  ecto_repos: [ Phx.Repo ],

)

config( :phx, PhxWeb.Endpoint,

  url: [ host: "localhost" ],

  secret_key_base: "eeSJJTu1RTAIqY0ZqpPiVaKF5Szc5E158IU/b7BzvWdHed7rOciJrJVCVES0Mzw5",

  render_errors: [ view: PhxWeb.ErrorView, layout: { PhxWeb.LayoutView, "error.html" }, accepts: ~w( html json ) ],

  pubsub: [ name: Phx.PubSub, adapter: Phoenix.PubSub.PG2 ],

)

config( :phx, :jsroutes,

  router: PhxWeb.Router,

  exclude: ~r{/admin},

  output_folder: "assets/source",

  output_file: "routes.js",

)


import_config( "#{ Mix.env }.exs" )
