class PagesController < ApplicationController
  def index
    if current_user
      @last = Art.order_by(:created_at, :desc).limit(10)
      render :layout => 'splash'
    else
      render 'notloggedin', :layout => 'splash'
    end
  end

  def help
  end

  def notloggedin
  end

end
