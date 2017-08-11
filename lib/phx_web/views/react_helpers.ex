defmodule PhxWeb.ReactHelpers do

  defmacro defview( name, assigns, do: expression ) do

    quote do

      def render( unquote( name <> ".json" ), unquote( assigns ) ), do: unquote( expression )

      def render( unquote( name <> ".html" ), assigns ) do

        PhxWeb.LayoutView.render( "react.html", Map.merge( assigns, %{

          json: render( unquote( name <> ".json" ), assigns ),

        } ) )

      end

    end

  end

end
