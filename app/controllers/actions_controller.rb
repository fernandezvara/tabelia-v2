class ActionsController < ApplicationController
  
  before_filter :check_user_is_logged
  
  def follow
    begin
      @remote_user = User.where(:username => params[:username]).first
      if current_user != @remote_user
        @result = GraphClient.new('Follow', current_user, @remote_user)
      else
        @result = "Relation not valid."
      end
    rescue
      ## log that someone are making something bad :)
      @result = "someone..."
    end
  end

  def unfollow
    begin
      @remote_user = User.where(:username => params[:username]).first
      @result = GraphClient.remove('Follow', current_user, @remote_user)
    rescue
      ## log that someone are making something bad :)
      #@result = "someone..."
    end
  end

  def like
    begin
      @art = Art.where(:slug => params[:slug]).first
      if current_user != @art.user
        @result = GraphClient.new('Like', current_user, @art)
      else
        @result = "Relation not valid."
      end
    rescue
      ## log that someone are making something bad :)
      @result = "someone..."
    end
  end

  def unlike
    begin
      @art = Art.where(:slug => params[:slug]).first
      @result = GraphClient.remove('Like', current_user, @art)
    rescue
      ## log that someone are making something bad :)
      #@result = "someone..."
    end
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
