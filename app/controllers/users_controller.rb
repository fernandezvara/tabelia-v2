class UsersController < ApplicationController
  
  def show
    @user = User.where(:username => params[:username]).first
    @comment = Comment.new
    @title = @user.name.to_s
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end
  
  def index
    @users = User.page(params[:page]).per(30)
    @title = t("users.index.title")
    render :layout => 'main'
  end

  def new
  end

  def create
  end



  def update
  end

end
