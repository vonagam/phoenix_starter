defmodule PhxWeb.Endpoint do

  use Phoenix.Endpoint, otp_app: :phx


  socket( "/socket", PhxWeb.UserSocket )

  plug( Plug.Static, at: "/", from: :phx )

  plug( TrailingFormatPlug )

  if code_reloading? do

    socket( "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket )

    plug( Phoenix.LiveReloader )

    plug( Phoenix.CodeReloader )

  end

  plug( Plug.RequestId )

  plug( Plug.Logger )

  plug( Plug.Parsers, parsers: [ :urlencoded, :multipart, :json ],  pass: [ "*/*" ], json_decoder: Poison )

  plug( Plug.MethodOverride )

  plug( Plug.Head )

  plug( Plug.Session, store: :cookie, key: "_phx_key", signing_salt: "ChXyaTBh" )

  plug( PhxWeb.Router )


  def init( _key, config ) do

    if config[ :load_from_system_env ] do

      port = System.get_env( "PORT" ) || raise "expected the PORT environment variable to be set"

      { :ok, Keyword.put( config, :http, [ :inet6, port: port ] ) }

    else

      { :ok, config }

    end

  end

end
