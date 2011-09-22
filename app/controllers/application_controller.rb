class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  before_filter :last_page_to_session
  
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
  
end
