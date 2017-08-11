defmodule PhxWeb.Router do

  use PhxWeb, :router


  pipeline :browser do

    plug( :accepts, ~w( html json ) )

    plug( :put_layout_formats, ~w( html json ) )

    plug( :fetch_session )

    plug( :fetch_flash )

    plug( :protect_from_forgery )

    plug( :put_secure_browser_headers )

  end


  scope "/", PhxWeb do

    pipe_through( :browser )


    get( "/", PageController, :index )

  end

end
