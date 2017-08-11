require IEx


defmodule PhxWeb.LayoutView do

  use PhxWeb, :view


  def render( "app.json", %{ conn: conn, view_module: view_module, view_template: view_template } = assigns ) do

    do_render_json( conn, render( view_module, view_template, assigns ) )

  end


  defp do_render_json( conn = %Plug.Conn{}, view ) do

    location = %{

      protocol: Atom.to_string( conn.scheme ) <> ":",

      hostname: conn.host,

      port: if( conn.port == 80 || conn.port == 443, do: "", else: Integer.to_string( conn.port ) ),

      pathname: conn.request_path,

      search: conn.query_string,

      query: conn.query_params,

    }

    location = Map.put( location, :host, location.hostname <> prepend_delimiter( ":", location.port ) )

    location = Map.put( location, :host, location.protocol <> "//" <> location.host <> location.pathname <> prepend_delimiter( "?", location.search ) )


    %{

      location: location,

      controller: Phoenix.Controller.controller_module( conn ),

      action: Phoenix.Controller.action_name( conn ),

      csrf: Phoenix.Controller.get_csrf_token(),

      flash: Phoenix.Controller.get_flash( conn ),

      # locale

      # user

      view: view,

    }

  end

  defp prepend_delimiter( _delimiter, "" ), do: ""

  defp prepend_delimiter( delimiter, value ), do: delimiter <> value

end
