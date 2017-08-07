defmodule PhxWeb.ErrorView do

  use PhxWeb, :view


  # def render( "404.html", input = %{ conn: %Plug.Conn{ assigns: %{ layout: false } } } ) do

  #   render( "404.html", put_in( input, [ :conn, Access.key( :assigns ), :layout ], "app.html" ) )

  # end

  def render( "500.html", _assigns ) do

    "Internal server error"

  end

  def template_not_found( _template, assigns ) do

    render "500.html", assigns

  end

end
