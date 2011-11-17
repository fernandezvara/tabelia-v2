#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :current_cart
  
  before_filter :last_page_to_session, :load_categories, :set_locale, :redirect_to_profile_edit, :rel_canonical
  
  def rel_canonical
    if Rails.env.development?
      @canonical = 'http://localhost:3000' + request.fullpath
    else
      @canonical = 'http://www.tabelia.com' + request.fullpath
    end
    logger.debug '@canonical=' + @canonical
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
    logger.debug "DEBUG: languages: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
     if action_name != 'set'
      if current_user
        if current_user.language != session[:locale]
          u = current_user
          u.language = session[:locale]
          u.save
        end
      end

      if session[:locale].nil?
        logger.debug "DEBUG: no hay locale en session"
        if current_user
          logger.debug "DEBUG: usando lenguage del usuario: #{current_user.locale}"
          session[:locale] = current_user.language
          I18n.locale = current_user.language.to_sym
        else
          temp_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/[a-z]{2}/).first
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
  
  def rescue_from_routing_error
    rescue_from ActionController::RoutingError do
      show_404
    end
  end
  
  def show_404
    redirect_to not_found_url
  end
  
  def current_cart
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
    @current_cart
  end
  
  def last_page_to_session
    # writes what was the last page the user visited. To return where you was before log in.
    if params[:go]
      session[:return_to] = params[:go]
    else
      session[:return_to] = request.fullpath if request.get? and controller_name != "sessions" and controller_name != "locale" and action_name != "new" and action_name != "new_modal" and action_name != 'new_provider' and action_name != 'signup'
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
  
  private
  
  def current_user
      @current_user ||= User.where(:auth_token => cookies[:auth_token]).first if cookies[:auth_token]
  end
  
  def load_categories
    @categories = Category.all
  end
  
end
