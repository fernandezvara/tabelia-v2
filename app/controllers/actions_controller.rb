class ActionsController < ApplicationController
  
  before_filter :check_user_is_logged
  
  def follow
    begin
      @user = User.where(:username => params[:username]).first
      if current_user != @user
        @result = GraphClient.new('Follow', current_user, @user)
        data = Hash.new
        data['who'] = current_user.id.to_s
        data['when'] = Time.now
        data['what'] = "ufu"
        data['to'] = @user.id.to_s
        Resque.enqueue(Notificator, data)
        Resque.enqueue(CreateRecommendations, current_user.id.to_s, 'follows_user', @user.class.to_s, @user.id.to_s)
      else
        @result = "Relation not valid."
      end
    rescue
      ## log that someone are making something bad :)
      @result = "someone..."
    end
  end

  def unfollow
    #begin
      @user = User.where(:username => params[:username]).first
      @result = GraphClient.remove('Follow', current_user, @user)
      Resque.enqueue(DeleteCounters, 'unfollow', @remote_user.class.to_s, @user.id.to_s)
      puts "@result =  #{@result}"
    #rescue
      ## log that someone are making something bad :)
      #@result = "someone..."
    #end
  end

  def like
    begin
      @art = Art.where(:slug => params[:slug]).first
      if current_user != @art.user
        @result = GraphClient.new('Like', current_user, @art)
        data = Hash.new
        data['who'] = current_user.id.to_s
        data['when'] = Time.now
        data['what'] = "ula"
        data['art'] = @art.id.to_s
        Resque.enqueue(Notificator, data)
        Resque.enqueue(CreateRecommendations, current_user.id.to_s, 'like_art', @art.class.to_s, @art.id.to_s)
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
      Resque.enqueue(DeleteCounters, 'unlike', @art.class.to_s, @art.id.to_s)
    rescue
      ## log that someone are making something bad :)
      @result = "someone..."
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
