class ActionsController < ApplicationController
  
  before_filter :check_user_is_logged
  
  def follow
    begin
      @remote_user = User.where(:username => params[:username]).first
      @result = GraphClient.new('Follow', current_user, @remote_user)
    rescue
      ## log that someone are making something bad :)
      @result = "someone..."
    end
  end

  def unfollow
    #begin
      @remote_user = User.where(:username => params[:username]).first
      @result = GraphClient.remove('Follow', current_user, @remote_user)
    #rescue
      ## log that someone are making something bad :)
      #@result = "someone..."
    #end
  end

  def like
  end

  def unlike
  end

  private
  
  def check_user_is_logged
    if current_user
      return true
    else
      return false
    end
  end

end
