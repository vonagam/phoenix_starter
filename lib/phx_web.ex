defmodule PhxWeb do

  defmacro __using__( which ) when is_atom( which ) do

    apply( __MODULE__, which, [] )

  end


  def controller do

    quote do

      import Plug.Conn

      use Phoenix.Controller, namespace: PhxWeb

      import PhxWeb.Router.Helpers

      import PhxWeb.Gettext

    end

  end

  def view do

    quote do

      use Phoenix.View, root: "lib/phx_web/templates", namespace: PhxWeb

      use Phoenix.HTML

      import Phoenix.Controller, only: [ get_flash: 2, view_module: 1 ]

      import PhxWeb.Router.Helpers

      import PhxWeb.ErrorHelpers

      import PhxWeb.ReactHelpers

      import PhxWeb.Gettext

    end

  end

  def router do

    quote do

      import Plug.Conn

      use Phoenix.Router

      import Phoenix.Controller

    end

  end

  def channel do

    quote do

      use Phoenix.Channel

      import PhxWeb.Gettext

    end

  end

end
