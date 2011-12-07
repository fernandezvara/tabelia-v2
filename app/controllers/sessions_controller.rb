class SessionsController < ApplicationController
  
  force_ssl :only => [ :new, :create, :create_external ]
  
  def new
    @user = User.new
    @title = t('sessions.new.title')
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      cookies.permanent[:auth_token] = user.auth_token
      if session[:return_to]
        @redirect = session[:return_to]
      else
        @redirect = root_url
      end
    else
      @error = "Invalid email or password"
    end
  end

  def create_external
    auth = request.env['omniauth.auth']

    remote_user = Authorization.where(:provider => auth["provider"], :uid => auth["uid"]).first
    
    if remote_user.nil?
      if current_user 
        current_user.authorizations.create!(:provider => auth["provider"], :uid => auth["uid"])
        notice = "You have associated your " + auth['provider'].titleize + " and Tabelia accounts! You can use it for log in later."
      else  
        random_password = ActiveSupport::SecureRandom.hex(10)
        new_user = User.create!(
          :email => auth["user_info"]["email"] || random_password.to_s + "@change.me", 
          :name => auth["user_info"]["name"] || "change_me", 
          :password => random_password, 
          :password_confirmation => random_password)
        cookies.permanent[:auth_token] = new_user.auth_token
        remote_user = Authorization.create!(:provider => auth["provider"], :uid => auth["uid"], :user => new_user)
        
        # Creates activity...
        #Activity.create! :what => 'signup', :activitable => new_user, :originator => new_user
        notice = "Welcome to tabelia!"
      end
    else
      if current_user
        auths_for_current_user = current_user.authorizations.where(:provider => auth["provider"], :uid => auth["uid"]).count
        if auths_for_current_user == 0
          notice = "You need to log out this account before log in again with other!"
        else
          notice = "You are already logged in!"
        end
      else
        user = remote_user.user
        cookies.permanent[:auth_token] = user.auth_token
        notice = "Logged in!"
      end
    end
    
    redirect_to_or_default(root_url, :notice => notice)

  end

  def destroy
    cookies.delete(:auth_token)
    session[:invoice_address] = nil if session[:invoice_address]
    session[:delivery_address] = nil if session[:delivery_address]
    session[:locale] = nil if session[:locale]
    redirect_to root_url, :notice => "Logged out!"
  end

end
