class UsersController < ApplicationController
  
  def show
    @user = User.where(:username => params[:username]).first
    @title = @user.name.to_s
    render :layout => 'main'
  end
  
  def index
  end

  def new
  end

  def create
  end



  def update
  end

end
