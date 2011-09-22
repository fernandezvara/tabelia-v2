class SessionsController < ApplicationController
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
  end

  def destroy
  end

end
