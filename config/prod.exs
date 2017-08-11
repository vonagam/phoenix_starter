use Mix.Config


config( :logger,

  level: :info,

)

config( :phx, PhxWeb.Endpoint,

  load_from_system_env: true,

  url: [ host: "example.com", port: 80 ],

  cache_static_manifest: "priv/static/cache_manifest.json",

)


import_config( "prod.secret.exs" )
