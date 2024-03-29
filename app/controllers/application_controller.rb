#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :current_cart
  
  before_filter :last_page_to_session, :load_categories, :set_locale, :redirect_to_profile_edit, :rel_canonical, :confirmed?, :user_location
  
  after_filter :set_access_control_headers
  
  def user_location
    if session[:location_city] 
      @city = session[:location_city]
    else
      @city = request.location.city
      session[:location_city] = request.location.city
    end
    if session[:location_country]
      @country = session[:location_country]
    else
      @country = request.location.country_code
      session[:location_country] = request.location.country_code
    end
    if session[:location_long]
      @long = session[:location_long]
    else
      @long = request.location.longitude
      session[:location_long] = request.location.longitude
    end
    if session[:location_lat]
      @lat = session[:location_lat]
    else
      @lat = request.location.latitude
      session[:location_lat] = request.location.latitude
    end
  end
  
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://www.tabelia.com/, https://www.tabelia.com/'
    headers['Access-Control-Request-Method'] = '*'
  end
  
  def rel_canonical
    if Rails.env.development?
      # @canonical = 'http://localhost:3000' + request.fullpath
      @canonical = 'http://www.tabelia.com:3000' + request.fullpath
    else
      @canonical = 'http://www.tabelia.com' + request.fullpath
    end
    if controller_name == "arts" or controller_name == "photos" or controller_name == "stock"
      if action_name == "show"
        case controller_name
        when "arts"
          @fb_canonical = art_profile_url(:slug => params[:slug])
        when "photos"
          @fb_canonical = photo_profile_url(:slug => params[:slug])
        when "stock"
          @fb_canonical = fotolia_show_url(:id => params[:id])
        end
      end
    end
  end
  
  def confirmed?
    if current_user
      if current_user.confirmed == false and current_user.email.nil? == false
        if session[:last_confirmation].nil? == true 
          session[:last_confirmation] = Time.now.to_i
          @show_confirmation = true
        else
          if session[:last_confirmation] < (Time.now.to_i - 1800)  # Si hace mas de 30 minutos volvemos a mostrar el mensaje
            session[:last_confirmation] = Time.now.to_i
            @show_confirmation = true
          else
            @show_confirmation = false
          end
        end
      end 
    end
  end
  
  def redirect_to_profile_edit
    if current_user and action_name != 'basic'
      if current_user.email.nil? == true or current_user.country_id.nil? == true
        flash[:error] = 'Por favor, rellena la información básica de tu perfil'
        redirect_to(profile_basic_path)
      end
    end
  end
  
  def set_locale
    if is_bot? == true
      if params[:locale] and params[:locale] == 'es'
        I18n.locale = :es
      else
        I18n.locale = :en
      end
    else
      if action_name != 'set'
        if current_user
          if current_user.language != session[:locale]
            session[:locale] = current_user.language if current_user.language.nil? == false
          end
        end

        if session[:locale].nil?
          logger.debug "DEBUG: no hay locale en session"
          if current_user
            logger.debug "DEBUG: usando lenguage del usuario: #{current_user.language}"
            session[:locale] = current_user.language || 'en'
            I18n.locale = current_user.language.to_sym rescue "en"
          else
            if request.env['HTTP_ACCEPT_LANGUAGE']
              temp_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/[a-z]{2}/).first
            else
              temp_locale = "en"
            end
            logger.debug "DEBUG: lenguage leido: #{temp_locale}"
            if I18n.available_locales.include?(temp_locale.to_sym)
              session[:locale] = temp_locale
              I18n.locale = temp_locale.to_sym
              logger.error "DEBUG: cambiado el lenguaje a: #{temp_locale}"
            else
              session[:locale] = I18n.default_locale
              I18n.locale = I18n.default_locale
              logger.debug "DEBUG: cambiado al lenguaje por defecto"
            end
          end
        else
          logger.debug "************DEBUG:usando locale en session: #{session[:locale]}"
          I18n.locale = session[:locale].to_sym
        end
      end 
    end
  end

  def rescue_from_routing_error
    rescue_from ActionController::RoutingError do
      show_404
    end
  end
  
  def show_404
    redirect_to not_found_url
  end
  
  def current_cart
    if is_bot? == false
      if cookies[:cart_id]
        begin
          @current_cart ||= Cart.find(cookies[:cart_id])
        rescue
          current_cart = Cart.new
          current_cart.save
          logger.debug '****** nueva Cart ID: ' + current_cart.id.to_s
          cookies.permanent[:cart_id] = current_cart.id.to_s
          @current_cart = current_cart
        end
      else
        current_cart = Cart.new
        current_cart.save
        logger.debug '****** nueva Cart ID: ' + current_cart.id.to_s
        cookies.permanent[:cart_id] = current_cart.id.to_s
        @current_cart = current_cart
      end
    else
      @current_cart ||= Cart.first
    end
    @current_cart
  end
  
  def last_page_to_session
    if is_bot? == false
      # writes what was the last page the user visited. To return where you was before log in.
      if params[:go]
        session[:return_to] = params[:go]
      else
        session[:return_to] = request.fullpath if request.get? and request.fullpath.include?('favicon') == false and controller_name != "sessions" and controller_name != "locale" and action_name != "new" and action_name != "new_modal" and action_name != 'new_provider' and action_name != 'signup' and action_name != 'confirmation' and action_name != 'add_to_cart' and action_name != 'search'
      end
    end
  end
  
  def redirect_to_or_default(default = :root, options = {})
    if session[:return_to]
      where_to_go = session[:return_to]
    else
      where_to_go = default
    end
    redirect_to(where_to_go, options)
  end
  
  def fotolia_category_name(id)
    #Existe en el helper y en el controller!!!!! Es necesario cambiar los dos!!!!!
    case I18n.locale.to_s
    when 'en'
      case id.to_i
      when 1000000
        return 'Landscapes'
      when 2000000
        return 'Architecture'
      when 3000000
        return 'People'
      when 4000000
        return 'Animals and Plants'
      when 5000000
        return 'Objects'
      when 6000000
        return 'Transportation'
      when 7000000
        return 'Food and Drink'
      when 8000000
        return 'Sports and Leisure'
      when 9000000
        return 'Backgrounds and Textures'
      when 10000000
        return 'Abstract'
      when 99000000
        return 'Others'
      end
    when 'es'
      case id.to_i
      when 1000000
        return 'Paisaje'
      when 2000000
        return 'Arquitectura'
      when 3000000
        return 'Personas'
      when 4000000
        return 'Animales y Plantas'
      when 5000000
        return 'Objetos'
      when 6000000
        return 'Transporte'
      when 7000000
        return 'Gastronomía'
      when 8000000
        return 'Deporte y Tiempo Libre'
      when 9000000
        return 'Fondo y Textura'
      when 10000000
        return 'Abstracto'
      when 99000000
        return 'Otros'
      end
    end
  end
  
  private
  
  def current_user
    @current_user ||= User.where(:auth_token => cookies[:auth_token]).first if cookies[:auth_token]
  end
  
  def load_categories
    @categories ||= Category.order_by(:name, :asc)
    @idioms ||= Genre.order_by(:name, :asc)
    @subjects ||= Subject.order_by(:name, :asc)
    @tecniques ||= Tecnique.order_by(:name, :asc)
    @languages ||= LANGUAGES
  end
  
  def is_bot?
    @bot ||= !(request.user_agent =~ /(Baidu|Bing|bot|Google|SiteUptime|Slurp|WordPress|ZIBB|ZyBorg)/i).nil?
  end
  
  
end
