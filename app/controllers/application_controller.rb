class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :current_cart
  
  before_filter :last_page_to_session, :load_categories
  
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
      session[:return_to] = request.fullpath if request.get? and controller_name != "sessions" and controller_name != "locale" and action_name != "new" and action_name != "new_modal"
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
