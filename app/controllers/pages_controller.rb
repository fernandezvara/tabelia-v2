class PagesController < ApplicationController
  def index
    if current_user
      @last = Art.order_by(:created_at, :desc).limit(10)
      render :layout => 'splash'
    else
      render 'notloggedin', :layout => 'first_page'
    end
  end

  def help
  end

  def notloggedin
  end

  def not_found
    respond_to do |format|
      format.html do
        render :layout => 'main'
      end
    end
  end

end
