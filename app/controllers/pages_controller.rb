class PagesController < ApplicationController
  def index
    if current_user
      render :layout => 'main'
    else
      render 'notloggedin', :layout => 'main'
    end
  end

  def help
  end

  def notloggedin
  end

end
