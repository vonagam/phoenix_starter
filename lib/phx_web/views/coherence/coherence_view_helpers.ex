defmodule PhxWeb.Coherence.ViewHelpers do

  use Phoenix.HTML

  import PhxWeb.Gettext

  alias Coherence.Config


  @type conn :: Plug.Conn.t

  @type schema :: Ecto.Schema.t

  @seperator { :safe, "&nbsp; | &nbsp;" }

  @helpers PhxWeb.Router.Helpers

  @recover_link  dgettext( "coherence", "Forgot your password?" )

  @unlock_link   dgettext( "coherence", "Send an unlock email" )

  @register_link dgettext( "coherence", "Need An Account?" )

  @invite_link   dgettext( "coherence", "Invite Someone" )

  @confirm_link  dgettext( "coherence", "Resend confirmation email" )

  @signin_link   dgettext( "coherence", "Sign In" )

  @signout_link  dgettext( "coherence", "Sign Out" )


  def coherence_links( conn, which, opts \\ [] )

  def coherence_links( conn, :new_session, opts ) do

    recover_link = Keyword.get( opts, :recover, @recover_link )

    unlock_link = Keyword.get( opts, :unlock, @unlock_link )

    register_link = Keyword.get( opts, :register, @register_link )

    confirm_link = Keyword.get( opts, :confirm, @confirm_link )

    user_schema = Coherence.Config.user_schema


    [

      recover_link( conn, user_schema, recover_link ),

      unlock_link( conn, user_schema, unlock_link ),

      register_link( conn, user_schema, register_link ),

      confirmation_link( conn, user_schema, confirm_link ),

    ]

    |> List.flatten()

    |> concat( [] )

  end

  def coherence_links( conn, :layout, opts ) do

    list_tag = Keyword.get( opts, :list_tag, :li )

    signout_class = Keyword.get( opts, :signout_class, "navbar-form" )

    signin = Keyword.get( opts, :signin, @signin_link )

    signout = Keyword.get( opts, :signout, @signout_link )

    register = Keyword.get( opts, :register, @register_link )


    if Coherence.logged_in?( conn ) do

      current_user = Coherence.current_user( conn )

      [

        content_tag( list_tag, profile_link( current_user, conn ) ),

        content_tag( list_tag, signout_link( conn, signout, signout_class ) ),

      ]

    else

      signin_link = content_tag( list_tag, link( signin, to: coherence_path( @helpers, :session_path, conn, :new ) ) )

      if Config.has_option( :registerable ) && register do

        [

          content_tag( list_tag, link( register, to: coherence_path( @helpers, :registration_path, conn, :new ) ) ),

          signin_link,

        ]

      else

        signin_link

      end

    end

  end

  def coherence_path( module, route_name, conn, action ) do

    apply( module, route_name, [ conn, action ] )

  end

  def coherence_path( module, route_name, conn, action, opts ) do

    apply( module, route_name, [ conn, action, opts ] )

  end

  defp concat( [], acc ), do: Enum.reverse( acc )

  defp concat( [ h | t ], [] ), do: concat( t, [ h ] )

  defp concat( [ h | t ], acc ), do: concat( t, [ h, @seperator | acc ] )

  def recover_link( _conn, _user_schema, false ), do: []

  def recover_link( conn, user_schema, text ) do

    if( user_schema.recoverable?, do: [ recover_link( conn, text ) ], else: [] )

  end

  def recover_link( conn, text \\ @recover_link ) do

    link( text, to: coherence_path( @helpers, :password_path, conn, :new ) )

  end

  def register_link( _conn, _user_schema, false ), do: []

  def register_link( conn, user_schema, text ) do

    if( user_schema.registerable?, do: [ register_link( conn, text ) ], else: [] )

  end

  def register_link( conn, text \\ @register_link ) do

    link( text, to: coherence_path( @helpers, :registration_path, conn, :new ) )

  end

  def unlock_link( _conn, _user_schema, false ), do: []

  def unlock_link( conn, _user_schema, text ) do

    if( conn.assigns[ :locked ], do: [ unlock_link( conn, text ) ], else: [] )

  end

  def unlock_link( conn, text \\ @unlock_link ) do

    link( text, to: coherence_path( @helpers, :unlock_path, conn, :new ) )

  end

  def invitation_link( conn, text \\ @invite_link ) do

    link( text, to: coherence_path( @helpers, :invitation_path, conn, :new ) )

  end

  def signout_link( conn, text \\ @signout_link, signout_class \\ "" ) do

    link( text, to: coherence_path( @helpers, :session_path, conn, :delete ), method: :delete, class: signout_class )

  end

  def confirmation_link( _conn, _user_schema, false ), do: []

  def confirmation_link( conn, user_schema, text ) do

    if( user_schema.confirmable?, do: [ confirmation_link( conn, text ) ], else: [] )

  end

  def confirmation_link( conn, text \\ @confirm_link ) do

    link( text, to: coherence_path( @helpers, :confirmation_path, conn, :new ) )

  end

  def required_label(f, name, opts \\ [] ) do

    label f, name, opts do

      [

        "#{ humanize( name ) }\n",

        content_tag( :abbr, "*", class: "required", title: "required" ),

      ]

    end

  end

  def current_user( conn ) do

    Coherence.current_user( conn )

  end

  def logged_in?( conn ) do

    Coherence.logged_in?( conn )

  end

  defp profile_link( current_user, conn ) do

    if Config.user_schema.registerable? do

      link( current_user.name, to: coherence_path( @helpers, :registration_path, conn, :show ) )

    else

      current_user.name

    end

  end

end
